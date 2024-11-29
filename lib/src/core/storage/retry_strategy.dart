class RetryStrategy {
  const RetryStrategy({
    required this.shouldRetry,
    required this.retryCount,
    required this.retryDelay,
  });

  final bool shouldRetry;
  final int retryCount;
  final Duration retryDelay;
}