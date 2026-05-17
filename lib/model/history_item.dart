class HistoryItem {
  final String type;
  final int value;
  final DateTime createdAt;

  const HistoryItem({
    required this.type,
    required this.value,
    required this.createdAt,
  });
}
