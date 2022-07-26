import 'daily_time_frame_dto.dart';
import 'monthly_time_frame_dto.dart';
import 'weekly_time_frame_dto.dart';

class TimeFramesDTO {
  final DailyTimeFrameDTO dailyTimeFrameDTO;
  final MonthlyTimeFrameDTO monthlyTimeFrameDTO;
  final WeeklyTimeFrameDTO weeklyTimeFrameDTO;

  const TimeFramesDTO({
    required this.dailyTimeFrameDTO,
    required this.monthlyTimeFrameDTO,
    required this.weeklyTimeFrameDTO,
  });

  factory TimeFramesDTO.fromJson(Map<String, dynamic> json) {
    return TimeFramesDTO(
      dailyTimeFrameDTO:
          DailyTimeFrameDTO.fromJson(json['daily'] as Map<String, dynamic>),
      monthlyTimeFrameDTO:
          MonthlyTimeFrameDTO.fromJson(json['monthly'] as Map<String, dynamic>),
      weeklyTimeFrameDTO:
          WeeklyTimeFrameDTO.fromJson(json['weekly'] as Map<String, dynamic>),
    );
  }
}
