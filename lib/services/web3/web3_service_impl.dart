import 'dart:async';
import 'dart:js_interop';
import 'package:logger/logger.dart';
import 'package:web3_ai_assistant/core/constants/web3_constants.dart';
import 'package:web3_ai_assistant/core/utils/validators.dart';
import 'package:web3_ai_assistant/services/web3/models/wallet_connection_status.dart';
import 'package:web3_ai_assistant/services/web3/models/wallet_info.dart';
import 'package:web3_ai_assistant/services/web3/web3_service.dart';
import 'package:web3_ai_assistant/services/web3/models/token_balance.dart';
import 'package:web3_ai_assistant/services/web3/models/transaction_info.dart';

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

/// Implementation of Web3Service that handles MetaMask wallet interactions
/// Uses JS interop to communicate with the browser's ethereum provider
class Web3ServiceImpl implements Web3Service {
  Web3ServiceImpl({Logger? logger}) : _logger = logger ?? Logger();
  
  final Logger _logger;

  /// Broadcasts wallet connection state changes to listeners
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
    // Validate address format
    if (!Validators.isValidEthereumAddress(address)) {
      return null;
    }
    
    try {
      // For now, let's try to get balance directly via ethereum object
      final ethereum = _getEthereum();

      // Try to get balance via eth_getBalance RPC call
      final params = [address.toJS, 'latest'.toJS].toJS;
      final requestParams = {'method': 'eth_getBalance', 'params': params}.jsify()! as JSObject;

      final balanceHex = await ethereum.request(requestParams).toDart;

      if (balanceHex != null) {
        // Convert hex to BigInt
        final balanceStr = (balanceHex as JSString).toDart;
        final balance = BigInt.parse(balanceStr.replaceFirst('0x', ''), radix: Web3Constants.hexRadix);
        return balance;
      }
      return null;
    } catch (e) {
      _logger.e('Error getting balance: $e');
      return null;
    }
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
          return int.parse(chainIdHex.replaceFirst('0x', ''), radix: Web3Constants.hexRadix);
        }
      } catch (e) {
        // Property access failed, try RPC method
        _logger.d('chainId property access failed, falling back to RPC method');
      }

      // Try RPC method as fallback
      final requestParams = {'method': 'eth_chainId'}.jsify()! as JSObject;
      final chainIdHex = await ethereum.request(requestParams).toDart;

      if (chainIdHex != null) {
        final chainIdStr = (chainIdHex as JSString).toDart;
        return int.parse(chainIdStr.replaceFirst('0x', ''), radix: Web3Constants.hexRadix);
      }

      return null;
    } catch (e) {
      _logger.e('Error getting chain ID: $e');
      return null;
    }
  }

  @override
  Future<String?> getNetworkName(int chainId) async {
    return _getNetworkName(chainId);
  }

  /// Maps chain ID to human-readable network name
  String _getNetworkName(int chainId) {
    final networks = {
      Web3Constants.ethereumMainnet: 'Ethereum Mainnet',
      Web3Constants.ropstenTestnet: 'Ropsten Testnet',
      Web3Constants.rinkebyTestnet: 'Rinkeby Testnet',
      Web3Constants.goerliTestnet: 'Goerli Testnet',
      Web3Constants.sepoliaTestnet: 'Sepolia Testnet',
      Web3Constants.polygonMainnet: 'Polygon Mainnet',
      Web3Constants.polygonMumbai: 'Polygon Mumbai',
      Web3Constants.bscMainnet: 'BSC Mainnet',
      Web3Constants.bscTestnet: 'BSC Testnet',
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
      _logger.d('Error checking MetaMask availability: $e');
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

  /// Fetches token balances for common ERC-20 tokens and native ETH
  /// Returns empty list if MetaMask is not available or on error
  @override
  Future<List<TokenBalance>> getTokenBalances(String walletAddress) async {
    // Validate address format
    if (!Validators.isValidEthereumAddress(walletAddress)) {
      _logger.w('Invalid wallet address format: $walletAddress');
      return [];
    }
    
    try {
      if (!_isMetaMaskAvailable()) {
        return [];
      }

      final ethereum = _getEthereum();
      final tokenBalances = <TokenBalance>[];

      // Common ERC-20 tokens with their contract addresses (Ethereum mainnet)
      // These are checked for balances when fetching portfolio
      final commonTokens = <Map<String, dynamic>>[
        {
          'symbol': 'USDT',
          'name': 'Tether USD',
          'contractAddress': '0xdAC17F958D2ee523a2206206994597C13D831ec7',
          'decimals': Web3Constants.tokenDecimals['USDT'],
        },
        {
          'symbol': 'USDC',
          'name': 'USD Coin',
          'contractAddress': '0xA0b86a33E6441b8a80204c64C41e5b35c38a1A8e',
          'decimals': Web3Constants.tokenDecimals['USDC'],
        },
        {
          'symbol': 'WETH',
          'name': 'Wrapped Ether',
          'contractAddress': '0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2',
          'decimals': Web3Constants.tokenDecimals['WETH'],
        },
        {
          'symbol': 'WBTC',
          'name': 'Wrapped Bitcoin',
          'contractAddress': '0x2260FAC5E5542a773Aa44fBcfeDf7C193bc2C599',
          'decimals': Web3Constants.tokenDecimals['WBTC'],
        },
        // Add ETH balance as native token
        {'symbol': 'ETH', 'name': 'Ethereum', 'contractAddress': 'native', 'decimals': Web3Constants.tokenDecimals['ETH']},
      ];

      // ERC-20 balanceOf function signature
      const balanceOfSignature = Web3Constants.balanceOfSignature; // keccak256("balanceOf(address)")[:8]

      for (final token in commonTokens) {
        try {
          BigInt balance;

          if (token['contractAddress'] == 'native') {
            // Get native ETH balance
            try {
              final params = [walletAddress.toJS, 'latest'.toJS].toJS;
              final requestParams = {'method': 'eth_getBalance', 'params': params}.jsify()! as JSObject;

              final result = await ethereum.request(requestParams).toDart;

              if (result != null) {
                final balanceHex = (result as JSString).toDart;
                balance = BigInt.parse(balanceHex.replaceFirst('0x', ''), radix: Web3Constants.hexRadix);
              } else {
                continue;
              }
            } catch (e) {
              _logger.e('Failed to get native ETH balance: $e');
              continue;
            }
          } else {
            // Get ERC-20 token balance
            try {
              // Encode the address parameter (remove 0x prefix and pad to 64 chars)
              final addressParam = walletAddress.replaceFirst('0x', '').padLeft(Web3Constants.addressPadLength, '0');
              final data = '$balanceOfSignature$addressParam';
              final params =
                  [
                    {'to': token['contractAddress'], 'data': data}.jsify(),
                    'latest'.toJS,
                  ].toJS;

              final requestParams = {'method': 'eth_call', 'params': params}.jsify()! as JSObject;

              final result = await ethereum.request(requestParams).toDart;

              if (result != null) {
                final balanceHex = (result as JSString).toDart;
                balance = BigInt.parse(balanceHex.replaceFirst('0x', ''), radix: Web3Constants.hexRadix);
              } else {
                continue;
              }
            } catch (e) {
              _logger.e('Failed to get ERC-20 balance for ${token['symbol']}: $e');
              continue;
            }
          }

          // Add token if balance > 0 OR if it's ETH (show even with 0 balance for testing)
          if (balance > BigInt.zero || token['symbol'] == 'ETH') {
            final tokenBalance = TokenBalance(
              symbol: token['symbol'] as String,
              name: token['name'] as String,
              contractAddress: token['contractAddress'] as String,
              balance: balance,
              decimals: token['decimals'] as int,
            );
            tokenBalances.add(tokenBalance);
          }
        } catch (e) {
          // Continue with other tokens if one fails
          continue;
        }
      }

      return tokenBalances;
    } catch (e) {
      // Return empty list on error
      _logger.e('Error getting token balances: $e');
      return [];
    }
  }

  void _updateStatus(WalletConnectionStatus status) {
    _currentStatus = status;
    _connectionStatusController.add(status);
  }

  /// Fetches recent ERC-20 token transfer events for the wallet
  /// Looks back ~1000 blocks and returns both incoming and outgoing transfers
  @override
  Future<List<TransactionInfo>> getRecentTransactions(String walletAddress, {int limit = Web3Constants.defaultTransactionLimit}) async {
    // Validate address format
    if (!Validators.isValidEthereumAddress(walletAddress)) {
      _logger.w('Invalid wallet address format: $walletAddress');
      return [];
    }
    
    // Validate limit
    var effectiveLimit = limit;
    if (limit <= 0 || limit > 100) {
      _logger.w('Invalid limit: $limit. Using default.');
      effectiveLimit = Web3Constants.defaultTransactionLimit;
    }
    
    try {
      if (!_isMetaMaskAvailable()) {
        return [];
      }

      final ethereum = _getEthereum();
      final transactions = <TransactionInfo>[];

      // Get current block number
      final blockNumberParams = {'method': 'eth_blockNumber'}.jsify()! as JSObject;
      final currentBlockHex = await ethereum.request(blockNumberParams).toDart;
      
      if (currentBlockHex == null) {
        return [];
      }
      
      final currentBlock = int.parse(currentBlockHex.toString(), radix: 16);
      final fromBlock = (currentBlock - Web3Constants.defaultBlockLookback).clamp(0, currentBlock); // Look back ~1000 blocks
      
      // Create filter for Transfer events (ERC-20 tokens)
      // Transfer event signature: Transfer(address,address,uint256)
      const transferEventSignature = Web3Constants.transferEventSignature;
      
      // Get logs for incoming transfers
      final incomingLogsParams = {
        'method': 'eth_getLogs',
        'params': [
          {
            'fromBlock': '0x${fromBlock.toRadixString(16)}',
            'toBlock': '0x${currentBlock.toRadixString(16)}',
            'topics': [
              transferEventSignature, // Event signature
              null, // from (any)
              '0x000000000000000000000000${walletAddress.substring(2).toLowerCase()}', // to (padded address)
            ],
          }
        ],
      }.jsify()! as JSObject;
      
      // Get logs for outgoing transfers
      final outgoingLogsParams = {
        'method': 'eth_getLogs',
        'params': [
          {
            'fromBlock': '0x${fromBlock.toRadixString(16)}',
            'toBlock': '0x${currentBlock.toRadixString(16)}',
            'topics': [
              transferEventSignature, // Event signature
              '0x000000000000000000000000${walletAddress.substring(2).toLowerCase()}', // from (padded address)
              null, // to (any)
            ],
          }
        ],
      }.jsify()! as JSObject;
      
      // Fetch logs
      final [incomingLogsResponse, outgoingLogsResponse] = await Future.wait([
        ethereum.request(incomingLogsParams).toDart,
        ethereum.request(outgoingLogsParams).toDart,
      ]);
      
      // Process incoming transfers
      if (incomingLogsResponse != null) {
        final incomingLogs = incomingLogsResponse.dartify() as List? ?? [];
        for (final log in incomingLogs) {
          final transaction = await _parseTransferLog(log as Map<String, dynamic>, ethereum, false);
          if (transaction != null) {
            transactions.add(transaction);
          }
        }
      }
      
      // Process outgoing transfers
      if (outgoingLogsResponse != null) {
        final outgoingLogs = outgoingLogsResponse.dartify() as List? ?? [];
        for (final log in outgoingLogs) {
          final transaction = await _parseTransferLog(log as Map<String, dynamic>, ethereum, true);
          if (transaction != null) {
            transactions.add(transaction);
          }
        }
      }
      
      // Sort by block number (most recent first)
      transactions.sort((a, b) => b.blockNumber.compareTo(a.blockNumber));
      
      // Return limited results
      return transactions.take(effectiveLimit).toList();
    } catch (e) {
      // Return empty list on error
      _logger.e('Error getting recent transactions: $e');
      return [];
    }
  }

  Future<TransactionInfo?> _parseTransferLog(
    Map<String, dynamic> log,
    Ethereum ethereum,
    bool isOutgoing,
  ) async {
    try {
      final txHash = log['transactionHash'] as String;
      final blockNumber = int.parse(log['blockNumber'] as String, radix: 16);
      final contractAddress = log['address'] as String;
      final topics = log['topics'] as List;
      final data = log['data'] as String;
      
      // Parse addresses from topics
      final fromAddress = '0x${(topics[1] as String).substring(Web3Constants.topicAddressOffset)}';
      final toAddress = '0x${(topics[2] as String).substring(Web3Constants.topicAddressOffset)}';
      
      // Parse amount from data
      final amount = BigInt.parse(data.substring(Web3Constants.hexDataOffset), radix: Web3Constants.hexRadix);
      
      // Get block details for timestamp
      final blockParams = {
        'method': 'eth_getBlockByNumber',
        'params': [log['blockNumber'], false],
      }.jsify()! as JSObject;
      
      final blockResponse = await ethereum.request(blockParams).toDart;
      final block = blockResponse.dartify() as Map<String, dynamic>?;
      final timestamp = block != null
          ? DateTime.fromMillisecondsSinceEpoch(
              int.parse(block['timestamp'] as String, radix: 16) * 1000,
            )
          : DateTime.now();
      
      // Get token info (simplified - in production would cache token metadata)
      final tokenSymbol = await _getTokenSymbol(contractAddress, ethereum);
      final tokenDecimals = await _getTokenDecimals(contractAddress, ethereum);
      
      return TransactionInfo(
        hash: txHash,
        from: fromAddress,
        to: toAddress,
        value: BigInt.zero, // ERC-20 transfers don't have ETH value
        timestamp: timestamp,
        blockNumber: blockNumber,
        gasUsed: BigInt.zero, // Would need to fetch transaction receipt
        status: TransactionStatus.success, // Logs only exist for successful transactions
        contractAddress: contractAddress,
        tokenTransfers: [
          TokenTransfer(
            tokenAddress: contractAddress,
            from: fromAddress,
            to: toAddress,
            value: amount,
            tokenSymbol: tokenSymbol,
            tokenDecimals: tokenDecimals,
          ),
        ],
      );
    } catch (e) {
      _logger.e('Error parsing transfer log: $e');
      return null;
    }
  }

  Future<String> _getTokenSymbol(String contractAddress, Ethereum ethereum) async {
    try {
      // ERC-20 symbol() method signature
      const symbolSignature = Web3Constants.symbolSignature;
      
      final params = {
        'method': 'eth_call',
        'params': [
          {
            'to': contractAddress,
            'data': symbolSignature,
          },
          'latest',
        ],
      }.jsify()! as JSObject;
      
      final response = await ethereum.request(params).toDart;
      if (response != null && response.toString() != '0x') {
        // Parse the string from the response (simplified)
        return _parseStringFromHex(response.toString());
      }
    } catch (e) {
      // Log error but continue with fallback
      _logger.e('Failed to fetch token symbol for $contractAddress: $e');
    }
    
    // Return a default based on known contracts
    return Web3Constants.knownTokenContracts[contractAddress.toLowerCase()] ?? 'TOKEN';
  }

  Future<int> _getTokenDecimals(String contractAddress, Ethereum ethereum) async {
    try {
      // ERC-20 decimals() method signature
      const decimalsSignature = Web3Constants.decimalsSignature;
      
      final params = {
        'method': 'eth_call',
        'params': [
          {
            'to': contractAddress,
            'data': decimalsSignature,
          },
          'latest',
        ],
      }.jsify()! as JSObject;
      
      final response = await ethereum.request(params).toDart;
      if (response != null && response.toString() != '0x') {
        return int.parse(response.toString().substring(2), radix: 16);
      }
    } catch (e) {
      // Log error but continue with fallback
      _logger.e('Failed to fetch token decimals for $contractAddress: $e');
    }
    
    // Default to 18 decimals
    return Web3Constants.defaultDecimals;
  }

  String _parseStringFromHex(String hex) {
    try {
      if (hex.length < 130) {
        return 'TOKEN'; // Not enough data
      }
      
      // Skip 0x prefix and first 64 chars (offset)
      // Next 64 chars contain length
      final lengthHex = hex.substring(66, 130);
      final length = int.parse(lengthHex, radix: 16);
      
      // Get the actual string data
      final dataHex = hex.substring(130, 130 + (length * 2));
      
      // Convert hex to string
      final bytes = <int>[];
      for (var i = 0; i < dataHex.length; i += 2) {
        bytes.add(int.parse(dataHex.substring(i, i + 2), radix: 16));
      }
      
      return String.fromCharCodes(bytes);
    } catch (e) {
      _logger.d('Error parsing hex string: $e');
      return 'TOKEN';
    }
  }

  @override
  void dispose() {
    _connectionStatusController.close();
  }
}
