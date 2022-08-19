import 'package:equatable/equatable.dart';

class Activity extends Equatable{
  final String categoryName;
  final DateTime createdAt;
  final Duration duration;

  const Activity({
    required this.categoryName,
    required this.createdAt,
    required this.duration,
  });

  @override
  List<Object?> get props => [categoryName, createdAt, duration];

}
