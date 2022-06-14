import 'package:json_annotation/json_annotation.dart';

part 'patient.g.dart';

@JsonSerializable()
class Patient {
  Patient();

  late String userName;
  late String name;
  late String email;
  String? gender;
  String? dateOfBirth;
  String? address;
  String? phoneNumber;
  String? disease;
  List? prescriptions;
  
  factory Patient.fromJson(Map<String,dynamic> json) => _$PatientFromJson(json);
  Map<String, dynamic> toJson() => _$PatientToJson(this);
}
