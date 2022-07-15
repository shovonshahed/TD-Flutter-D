import 'package:json_annotation/json_annotation.dart';

part 'mapLocation.g.dart';

@JsonSerializable()
class MapLocation {
  MapLocation();

  late String latitude;
  late String longitude;
  
  factory MapLocation.fromJson(Map<String,dynamic> json) => _$MapLocationFromJson(json);
  Map<String, dynamic> toJson() => _$MapLocationToJson(this);
}
