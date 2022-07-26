class WeeklyTimeFrameDTO {
  final int current;
  final int previous;

  const WeeklyTimeFrameDTO({
    required this.current,
    required this.previous,
  });

  factory WeeklyTimeFrameDTO.fromJson(Map<String, dynamic> json) {
    return WeeklyTimeFrameDTO(
      current: json['current'] as int,
      previous: json['previous'] as int,
    );
  }
}
