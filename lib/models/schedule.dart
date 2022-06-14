import 'package:json_annotation/json_annotation.dart';

part 'schedule.g.dart';

@JsonSerializable()
class Schedule {
  Schedule();

  late num scheduleId;
  late num dayOfWeek;
  late String startTime;
  late String endTime;
  
  factory Schedule.fromJson(Map<String,dynamic> json) => _$ScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}
