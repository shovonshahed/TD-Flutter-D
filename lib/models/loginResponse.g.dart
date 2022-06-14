// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loginResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse()
      ..token = json['token'] as String
      ..dataToReturn =
          Doctor.fromJson(json['dataToReturn'] as Map<String, dynamic>);

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'dataToReturn': instance.dataToReturn,
    };
