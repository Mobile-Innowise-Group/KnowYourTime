import 'time_frames_dto.dart';

class TimeFrameDTO {
  final TimeFramesDTO timeframes;
  final String title;

  const TimeFrameDTO({
    required this.timeframes,
    required this.title,
  });

  factory TimeFrameDTO.fromJson(Map<String, dynamic> json) {
    return TimeFrameDTO(
      title: json['title'].toString(),
      timeframes:
          TimeFramesDTO.fromJson(json['timeframes'] as Map<String, dynamic>),
    );
  }
}
