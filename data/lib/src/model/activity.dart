class Activity {
  final String categoryId;
  final String userId;
  final DateTime createdAt;
  final Duration duration;
  final String id;

  Activity({
    required this.categoryId,
    required this.createdAt,
    required this.duration,
    required this.userId,
    required this.id,
  });
}
