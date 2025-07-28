import 'dart:async';
import 'dart:js_interop';
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

  @override
  Future<List<TokenBalance>> getTokenBalances(String walletAddress) async {
    try {
      if (!_isMetaMaskAvailable()) {
        return [];
      }

      final ethereum = _getEthereum();
      final tokenBalances = <TokenBalance>[];

      // Common ERC-20 tokens with their contract addresses (Ethereum mainnet)
      final commonTokens = <Map<String, dynamic>>[
        {
          'symbol': 'USDT',
          'name': 'Tether USD',
          'contractAddress': '0xdAC17F958D2ee523a2206206994597C13D831ec7',
          'decimals': 6,
        },
        {
          'symbol': 'USDC',
          'name': 'USD Coin',
          'contractAddress': '0xA0b86a33E6441b8a80204c64C41e5b35c38a1A8e',
          'decimals': 6,
        },
        {
          'symbol': 'WETH',
          'name': 'Wrapped Ether',
          'contractAddress': '0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2',
          'decimals': 18,
        },
        {
          'symbol': 'WBTC',
          'name': 'Wrapped Bitcoin',
          'contractAddress': '0x2260FAC5E5542a773Aa44fBcfeDf7C193bc2C599',
          'decimals': 8,
        },
        // Add ETH balance as native token
        {'symbol': 'ETH', 'name': 'Ethereum', 'contractAddress': 'native', 'decimals': 18},
      ];

      // ERC-20 balanceOf function signature
      const balanceOfSignature = '0x70a08231'; // keccak256("balanceOf(address)")[:8]

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
                balance = BigInt.parse(balanceHex.replaceFirst('0x', ''), radix: 16);
              } else {
                continue;
              }
            } catch (e) {
              continue;
            }
          } else {
            // Get ERC-20 token balance
            try {
              // Encode the address parameter (remove 0x prefix and pad to 64 chars)
              final addressParam = walletAddress.replaceFirst('0x', '').padLeft(64, '0');
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
                balance = BigInt.parse(balanceHex.replaceFirst('0x', ''), radix: 16);
              } else {
                continue;
              }
            } catch (e) {
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
      return [];
    }
  }

  void _updateStatus(WalletConnectionStatus status) {
    _currentStatus = status;
    _connectionStatusController.add(status);
  }

  @override
  Future<List<TransactionInfo>> getRecentTransactions(String walletAddress, {int limit = 10}) async {
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
      final fromBlock = (currentBlock - 1000).clamp(0, currentBlock); // Look back ~1000 blocks
      
      // Create filter for Transfer events (ERC-20 tokens)
      // Transfer event signature: Transfer(address,address,uint256)
      const transferEventSignature = '0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef';
      
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
      return transactions.take(limit).toList();
    } catch (e) {
      // Return empty list on error
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
      final fromAddress = '0x${(topics[1] as String).substring(26)}';
      final toAddress = '0x${(topics[2] as String).substring(26)}';
      
      // Parse amount from data
      final amount = BigInt.parse(data.substring(2), radix: 16);
      
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
      return null;
    }
  }

  Future<String> _getTokenSymbol(String contractAddress, Ethereum ethereum) async {
    try {
      // ERC-20 symbol() method signature
      const symbolSignature = '0x95d89b41';
      
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
      // Ignore errors
    }
    
    // Return a default based on known contracts
    final knownTokens = {
      '0xdac17f958d2ee523a2206206994597c13d831ec7': 'USDT',
      '0xa0b86991c5040be1dc552d61ff7e8bfc7ae3e2b4': 'USDC',
      '0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2': 'WETH',
    };
    
    return knownTokens[contractAddress.toLowerCase()] ?? 'TOKEN';
  }

  Future<int> _getTokenDecimals(String contractAddress, Ethereum ethereum) async {
    try {
      // ERC-20 decimals() method signature
      const decimalsSignature = '0x313ce567';
      
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
      // Ignore errors
    }
    
    // Default to 18 decimals
    return 18;
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
      return 'TOKEN';
    }
  }

  @override
  void dispose() {
    _connectionStatusController.close();
  }
}
