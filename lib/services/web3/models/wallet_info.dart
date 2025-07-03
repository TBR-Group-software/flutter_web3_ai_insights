class WalletInfo {

  WalletInfo({
    required this.address,
    this.balance,
    this.chainId,
    this.networkName,
  });
  final String address;
  final BigInt? balance;
  final int? chainId;
  final String? networkName;

  String get shortAddress {
    if (address.length < 10) {
      return address;
    }
    return '${address.substring(0, 6)}...${address.substring(address.length - 4)}';
  }

  String get formattedBalance {
    if (balance == null) {
      return '0 ETH';
    }
    final eth = balance! / BigInt.from(10).pow(18);
    return '${eth.toStringAsFixed(4)} ETH';
  }

  WalletInfo copyWith({
    String? address,
    BigInt? balance,
    int? chainId,
    String? networkName,
  }) {
    return WalletInfo(
      address: address ?? this.address,
      balance: balance ?? this.balance,
      chainId: chainId ?? this.chainId,
      networkName: networkName ?? this.networkName,
    );
  }
}
