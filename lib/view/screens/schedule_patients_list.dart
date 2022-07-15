import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:teledoc_doctor/models/index.dart';
import 'package:teledoc_doctor/services/network_service.dart';
import 'package:teledoc_doctor/view/screens/patient_details_screen.dart';

import '../../controllers/doctor_controller.dart';
import '../widgets/appbar.dart';
import '../widgets/drawer.dart';

class SchedulePatientListScreen extends StatelessWidget {
  static const String id = 'schedules-list';
  SchedulePatientListScreen({Key? key, required this.schedule})
      : super(key: key);
  final Schedule schedule;

  final DoctorController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        title: "Patients",
      ),
      drawer: SideDrawer(
        pageName: 'patients-list',
      ),
      body: SafeArea(
        child: Column(
          children: [
            const ListTile(
              title: Text("Patients"),
            ),
            (schedule.patients != null && schedule.patients!.isNotEmpty)
                ? ListView.builder(
                    itemCount: schedule.patients!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () async {
                          Patient patient = await controller
                              .getUser(schedule.patients![index].patientEmail);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PatientDetails(patient: patient),
                              ));
                        },
                        leading: Icon(Icons.access_time),
                        title: Text(schedule.patients![index].patientEmail),
                      );
                    },
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
