import 'package:flutter/material.dart';
import 'package:teledoc_doctor/models/index.dart';

import '../widgets/appbar.dart';
import '../widgets/drawer.dart';

class PatientDetails extends StatelessWidget {
  static const String id = 'schedules-list';
  PatientDetails({Key? key, required this.patient}) : super(key: key);
  final Patient patient;

  calculateAge(String? dateOfBirth) {
    DateTime birthDate = DateTime.parse(dateOfBirth!);
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        title: patient.name,
      ),
      drawer: SideDrawer(
        pageName: 'patiet-name',
      ),
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: Text("Name"),
              subtitle: Text(patient.name),
            ),
            ListTile(
              title: Text("Age"),
              subtitle: Text(calculateAge(patient.dateOfBirth).toString()),
            ),
            ListTile(
              title: Text("Gender"),
              subtitle: Text(patient.gender ?? ""),
            ),
            ListTile(
              title: Text("Phone"),
              subtitle: Text(patient.phoneNumber ?? ""),
            ),
            ListTile(
              title: Text("Address"),
              subtitle: Text(patient.address ?? ""),
            ),
          ],
        ),
      ),
    );
  }
}
