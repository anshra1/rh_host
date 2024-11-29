class StackTraceParser {
  static String formatStackTrace(StackTrace stackTrace) {
    // Convert to string and split into lines
    final lines = stackTrace.toString().split('\n');

    // Get only relevant lines (usually first 3-5 lines)
    final relevantLines = lines.take(8).where((line) {
      // Filter out system/framework lines
      return !line.contains('dart:async') &&
          !line.contains('dart:core') &&
          !line.contains('package:flutter') &&
          !line.contains('package:test');
    });

    // Format each line to be more readable
    final formattedLines = relevantLines.map((line) {
      // Extract file path and line number
      final regex = RegExp(r'(?:package:)?([^\s]+)\s+([^\s]+)');
      final match = regex.firstMatch(line);
      if (match != null) {
        final file = match.group(1)?.split('/').last; // Get just filename
        final position = match.group(2);
        return '$file at $position';
      }
      return line;
    });

    return formattedLines.join('\n');
  }
}
