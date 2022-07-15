import 'package:flutter/material.dart';
import 'package:teledoc_doctor/models/index.dart';

import '../widgets/appbar.dart';
import '../widgets/drawer.dart';

class PatientDetails extends StatelessWidget {
  static const String id = 'schedules-list';
  PatientDetails({Key? key, required this.patient}) : super(key: key);
  final Patient patient;

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
          children: [],
        ),
      ),
    );
  }
}
