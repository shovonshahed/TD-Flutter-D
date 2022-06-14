// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) => Schedule()
  ..scheduleId = json['scheduleId'] as num
  ..dayOfWeek = json['dayOfWeek'] as num
  ..startTime = json['startTime'] as String
  ..endTime = json['endTime'] as String;

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'scheduleId': instance.scheduleId,
      'dayOfWeek': instance.dayOfWeek,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };
