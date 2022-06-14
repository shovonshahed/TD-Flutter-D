// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) => Patient()
  ..userName = json['userName'] as String
  ..name = json['name'] as String
  ..email = json['email'] as String
  ..gender = json['gender'] as String?
  ..dateOfBirth = json['dateOfBirth'] as String?
  ..address = json['address'] as String?
  ..phoneNumber = json['phoneNumber'] as String?
  ..disease = json['disease'] as String?
  ..prescriptions = json['prescriptions'] as List<dynamic>?;

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'userName': instance.userName,
      'name': instance.name,
      'email': instance.email,
      'gender': instance.gender,
      'dateOfBirth': instance.dateOfBirth,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
      'disease': instance.disease,
      'prescriptions': instance.prescriptions,
    };
