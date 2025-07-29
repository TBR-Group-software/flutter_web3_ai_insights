/// Utility class for input validation
class Validators {
  Validators._();

  /// Validates Ethereum wallet address format
  /// Returns true if valid, false otherwise
  static bool isValidEthereumAddress(String? address) {
    if (address == null || address.isEmpty) {
      return false;
    }
    
    // Check if it starts with 0x
    if (!address.startsWith('0x')) {
      return false;
    }
    
    // Check length (should be 42 characters: 0x + 40 hex chars)
    if (address.length != 42) {
      return false;
    }
    
    // Check if remaining characters are valid hex
    final hexPart = address.substring(2);
    final hexRegex = RegExp(r'^[0-9a-fA-F]+$');
    return hexRegex.hasMatch(hexPart);
  }

  /// Validates if a string is a valid hex number
  static bool isValidHex(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    
    // Remove 0x prefix if present
    final cleanValue = value.startsWith('0x') ? value.substring(2) : value;
    
    // Check if all characters are valid hex
    final hexRegex = RegExp(r'^[0-9a-fA-F]+$');
    return hexRegex.hasMatch(cleanValue);
  }

  /// Validates token symbol format
  static bool isValidTokenSymbol(String? symbol) {
    if (symbol == null || symbol.isEmpty) {
      return false;
    }
    
    // Token symbols should be uppercase alphanumeric, typically 3-5 chars
    final symbolRegex = RegExp(r'^[A-Z0-9]{2,10}$');
    return symbolRegex.hasMatch(symbol.toUpperCase());
  }

  /// Validates if a value is a positive number
  static bool isPositiveNumber(dynamic value) {
    if (value == null) {
      return false;
    }
    
    num? number;
    if (value is num) {
      number = value;
    } else if (value is String) {
      number = num.tryParse(value);
    }
    
    return number != null && number > 0;
  }

  /// Validates API response structure
  static bool isValidApiResponse(Map<String, dynamic>? response) {
    return response != null && response.isNotEmpty;
  }

  /// Sanitizes user input to prevent XSS
  static String sanitizeInput(String input) {
    return input
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#x27;')
        .replaceAll('/', '&#x2F;');
  }
}
