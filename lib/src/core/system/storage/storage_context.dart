class StorageErrorContext {
  const StorageErrorContext({
    this.key,
    this.operation,
    this.additionalInfo,
  });

  final String? key;
  final String? operation;
  final Map<String, dynamic>? additionalInfo;
}
