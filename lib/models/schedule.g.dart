// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) => Schedule()
  ..scheduleId = json['scheduleId'] as num?
  ..dayOfWeek = json['dayOfWeek'] as num
  ..startTime = json['startTime'] as String
  ..endTime = json['endTime'] as String
  ..patientLimit = json['patientLimit'] as num
  ..patients = (json['patients'] as List<dynamic>?)
      ?.map((e) => PatientMin.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'scheduleId': instance.scheduleId,
      'dayOfWeek': instance.dayOfWeek,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'patientLimit': instance.patientLimit,
      'patients': instance.patients,
    };
