import 'dart:async';
import 'dart:js_interop';
import 'package:web3_ai_assistant/services/web3/models/wallet_connection_status.dart';
import 'package:web3_ai_assistant/services/web3/models/wallet_info.dart';
import 'package:web3_ai_assistant/services/web3/web3_service.dart';

// JS interop definitions
@JS('window')
external Window get window;

@JS()
extension type Window(JSObject _) implements JSObject {
  external Ethereum? get ethereum;
}

@JS()
extension type Ethereum(JSObject _) implements JSObject {
  external bool? get isMetaMask;
  external String? get chainId;
  external JSPromise<JSAny?> request(JSObject params);
}

class Web3ServiceImpl implements Web3Service {
  Web3ServiceImpl();

  final _connectionStatusController = StreamController<WalletConnectionStatus>.broadcast();
  WalletConnectionStatus _currentStatus = WalletConnectionStatus.disconnected();
  String? _currentAddress;

  @override
  Stream<WalletConnectionStatus> get connectionStatusStream => _connectionStatusController.stream;

  @override
  WalletConnectionStatus get currentConnectionStatus => _currentStatus;

  @override
  Future<WalletConnectionStatus> connect() async {
    try {
      _updateStatus(WalletConnectionStatus.connecting());

      // Check if MetaMask is available
      final isAvailable = _isMetaMaskAvailable();

      if (!isAvailable) {
        throw Exception('MetaMask is not installed. Please install MetaMask extension.');
      }

      final ethereum = _getEthereum();

      // Request accounts
      final accounts = await _requestAccounts(ethereum);

      if (accounts.isEmpty) {
        throw Exception('No accounts found. Please unlock MetaMask.');
      }

      _currentAddress = accounts.first;

      // Get balance
      final balance = await getBalance(_currentAddress!);

      // Get chain ID
      final chainId = await getChainId();

      final walletInfo = WalletInfo(
        address: _currentAddress!,
        balance: balance,
        chainId: chainId,
        networkName: chainId != null ? _getNetworkName(chainId) : 'Unknown',
      );

      print('WalletInfo: ${walletInfo.chainId}');
      print('balance: $balance');

      final status = WalletConnectionStatus.connected(walletInfo);
      _updateStatus(status);

      return status;
    } catch (e) {
      final errorStatus = WalletConnectionStatus.error(e.toString());
      _updateStatus(errorStatus);
      return errorStatus;
    }
  }

  @override
  Future<WalletConnectionStatus> disconnect() async {
    _currentAddress = null;
    _updateStatus(WalletConnectionStatus.disconnected());
    final status = WalletConnectionStatus.disconnected();
    return status;
  }

  @override
  Future<BigInt?> getBalance(String address) async {
    try {
      // For now, let's try to get balance directly via ethereum object
      final ethereum = _getEthereum();

      try {
        // Try to get balance via eth_getBalance RPC call
        final params = [address.toJS, 'latest'.toJS].toJS;
        final requestParams = {'method': 'eth_getBalance', 'params': params}.jsify()! as JSObject;

        final balanceHex = await ethereum.request(requestParams).toDart;

        if (balanceHex != null) {
          // Convert hex to BigInt
          final balanceStr = (balanceHex as JSString).toDart;
          final balance = BigInt.parse(balanceStr.replaceFirst('0x', ''), radix: 16);
          return balance;
        }
      } catch (e) {
        return null;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Future<int?> getChainId() async {
    try {
      if (!_isMetaMaskAvailable()) {
        return null;
      }

      final ethereum = _getEthereum();

      // Try to get chainId property first
      try {
        final chainIdHex = ethereum.chainId;
        if (chainIdHex != null) {
          return int.parse(chainIdHex.replaceFirst('0x', ''), radix: 16);
        }
      } catch (e) {
        return null;
      }

      // Try RPC method
      try {
        final requestParams = {'method': 'eth_chainId'}.jsify()! as JSObject;
        final chainIdHex = await ethereum.request(requestParams).toDart;

        if (chainIdHex != null) {
          final chainIdStr = (chainIdHex as JSString).toDart;
          return int.parse(chainIdStr.replaceFirst('0x', ''), radix: 16);
        }
      } catch (e) {
        return null;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String?> getNetworkName(int chainId) async {
    return _getNetworkName(chainId);
  }

  String _getNetworkName(int chainId) {
    final networks = {
      1: 'Ethereum Mainnet',
      3: 'Ropsten Testnet',
      4: 'Rinkeby Testnet',
      5: 'Goerli Testnet',
      11155111: 'Sepolia Testnet',
      137: 'Polygon Mainnet',
      80001: 'Polygon Mumbai',
      56: 'BSC Mainnet',
      97: 'BSC Testnet',
    };

    return networks[chainId] ?? 'Unknown Network (ID: $chainId)';
  }

  bool _isMetaMaskAvailable() {
    try {
      final ethereum = window.ethereum;
      if (ethereum == null) {
        return false;
      }

      final isMetaMask = ethereum.isMetaMask ?? false;

      return isMetaMask;
    } catch (e) {
      return false;
    }
  }

  Ethereum _getEthereum() {
    final ethereum = window.ethereum;
    if (ethereum == null) {
      throw Exception('Ethereum provider not found');
    }
    return ethereum;
  }

  Future<List<String>> _requestAccounts(Ethereum ethereum) async {
    try {
      final requestParams = {'method': 'eth_requestAccounts'}.jsify()! as JSObject;
      final response = await ethereum.request(requestParams).toDart;

      if (response != null && response.dartify() is List) {
        final accountsList = response.dartify()! as List;
        return accountsList.map((e) => e.toString()).toList();
      }

      return [];
    } catch (e) {
      throw Exception('Failed to request accounts: $e');
    }
  }

  void _updateStatus(WalletConnectionStatus status) {
    _currentStatus = status;
    _connectionStatusController.add(status);
  }

  @override
  void dispose() {
    _connectionStatusController.close();
  }
}
