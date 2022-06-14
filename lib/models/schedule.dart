import 'package:json_annotation/json_annotation.dart';
import "patient.dart";
part 'schedule.g.dart';

@JsonSerializable()
class Schedule {
  Schedule();

  num? scheduleId;
  late num dayOfWeek;
  late String startTime;
  late String endTime;
  late num patientLimit;

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}
