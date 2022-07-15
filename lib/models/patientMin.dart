import 'package:json_annotation/json_annotation.dart';

part 'patientMin.g.dart';

@JsonSerializable()
class PatientMin {
  PatientMin();

  late num id;
  late String patientEmail;
  
  factory PatientMin.fromJson(Map<String,dynamic> json) => _$PatientMinFromJson(json);
  Map<String, dynamic> toJson() => _$PatientMinToJson(this);
}
