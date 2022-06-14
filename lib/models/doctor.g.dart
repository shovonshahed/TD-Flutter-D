// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctor _$DoctorFromJson(Map<String, dynamic> json) => Doctor()
  ..userName = json['userName'] as String
  ..name = json['name'] as String
  ..email = json['email'] as String
  ..gender = json['gender'] as String?
  ..dateOfBirth = json['dateOfBirth'] as String?
  ..address = json['address'] as String?
  ..phoneNumber = json['phoneNumber'] as String?
  ..speciality = json['speciality'] as String?
  ..college = json['college'] as String?
  ..certificateUrl = json['certificateUrl'] as String?
  ..schedules = (json['schedules'] as List<dynamic>)
      .map((e) => Schedule.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      'userName': instance.userName,
      'name': instance.name,
      'email': instance.email,
      'gender': instance.gender,
      'dateOfBirth': instance.dateOfBirth,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
      'speciality': instance.speciality,
      'college': instance.college,
      'certificateUrl': instance.certificateUrl,
      'schedules': instance.schedules,
    };
