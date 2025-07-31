/// Constants for Web3 interactions and blockchain networks
class Web3Constants {
  Web3Constants._();

  // Network Chain IDs
  static const int ethereumMainnet = 1;
  static const int ropstenTestnet = 3;
  static const int rinkebyTestnet = 4;
  static const int goerliTestnet = 5;
  static const int sepoliaTestnet = 11155111;
  static const int polygonMainnet = 137;
  static const int polygonMumbai = 80001;
  static const int bscMainnet = 56;
  static const int bscTestnet = 97;

  // ERC-20 Method Signatures
  static const String balanceOfSignature = '0x70a08231';
  static const String symbolSignature = '0x95d89b41';
  static const String decimalsSignature = '0x313ce567';
  static const String transferEventSignature = '0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef';

  // Transaction Parameters
  static const int defaultBlockLookback = 1000;
  static const int defaultTransactionLimit = 10;
  static const int defaultDecimals = 18;

  // Hex String Parsing
  static const int addressPadLength = 64;
  static const int topicAddressOffset = 26;
  static const int hexDataOffset = 2; // Skip '0x' prefix
  static const int hexRadix = 16;

  // Common Token Decimals
  static const Map<String, int> tokenDecimals = {
    'USDT': 6,
    'USDC': 6,
    'WETH': 18,
    'ETH': 18,
    'WBTC': 8,
  };

  // Known Token Contracts (Ethereum Mainnet)
  static const Map<String, String> knownTokenContracts = {
    '0xdac17f958d2ee523a2206206994597c13d831ec7': 'USDT',
    '0xa0b86991c5040be1dc552d61ff7e8bfc7ae3e2b4': 'USDC',
    '0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2': 'WETH',
  };
}
