class Activity {
  final String category_id;
  final String user_id;
  final DateTime created_at;
  final Duration duration;
  final String id;

  Activity({
    required this.category_id,
    required this.created_at,
    required this.duration,
    required this.user_id,
    required this.id,
  });
}
