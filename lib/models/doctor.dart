import 'package:json_annotation/json_annotation.dart';
import "mapLocation.dart";
import "schedule.dart";
part 'doctor.g.dart';

@JsonSerializable()
class Doctor {
  Doctor();

  late String userName;
  late String name;
  late String email;
  String? gender;
  String? dateOfBirth;
  String? address;
  String? phoneNumber;
  String? speciality;
  String? college;
  String? certificateUrl;
  MapLocation? mapLocation;
  late List<Schedule> schedules;
  
  factory Doctor.fromJson(Map<String,dynamic> json) => _$DoctorFromJson(json);
  Map<String, dynamic> toJson() => _$DoctorToJson(this);
}
