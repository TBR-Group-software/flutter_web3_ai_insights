class DateFormatter {
  DateFormatter._();

  /// Formats a DateTime into a relative time string (e.g., "2m ago", "3h ago")
  static String formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  /// Formats a DateTime into a relative time string with "Generated" prefix
  static String formatGeneratedRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Generated just now';
    } else if (difference.inMinutes < 60) {
      return 'Generated ${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return 'Generated ${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return 'Generated ${difference.inDays}d ago';
    } else {
      return 'Generated on ${formatDateTime(dateTime)}';
    }
  }

  /// Formats a DateTime into a readable string (e.g., "Today at 14:30" or "15/3 at 09:45")
  static String formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final isToday = dateTime.day == now.day && 
                    dateTime.month == now.month && 
                    dateTime.year == now.year;
    
    if (isToday) {
      return 'Today at ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
    
    return '${dateTime.day}/${dateTime.month} at ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
