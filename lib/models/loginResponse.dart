import 'package:json_annotation/json_annotation.dart';
import "doctor.dart";
part 'loginResponse.g.dart';

@JsonSerializable()
class LoginResponse {
  LoginResponse();

  late String token;
  late Doctor dataToReturn;
  
  factory LoginResponse.fromJson(Map<String,dynamic> json) => _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
