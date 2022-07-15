import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:teledoc_doctor/view/screens/add_schedule_screen.dart';
import 'package:teledoc_doctor/view/screens/schedule_patients_list.dart';
import '../../controllers/doctor_controller.dart';
import '/models/doctor.dart';

import '../widgets/appbar.dart';
import '../widgets/drawer.dart';

class SchedulesListScreen extends StatelessWidget {
  static const String id = 'schedules-list';
  SchedulesListScreen({Key? key}) : super(key: key);
  final DoctorController controller = Get.find();

  String getDayName(num dayOfWeek) {
    switch (dayOfWeek) {
      case 1:
        return "Saturday";
      case 2:
        return "Sunday";
      case 3:
        return "Monday";
      case 4:
        return "Tuesday";
      case 5:
        return "Wednesday";
      case 6:
        return "Thursday";
      case 7:
        return "Friday";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        title: "Schedules",
      ),
      drawer: SideDrawer(
        pageName: 'schedules-list',
      ),
      body: SafeArea(
        child: Column(
          children: [
            const ListTile(
              title: Text("Schedules"),
            ),
            Obx(() {
              final schedules = controller.schedules;
              return ListView.builder(
                itemCount: schedules.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SchedulePatientListScreen(
                              schedule: schedules[index]),
                        )),
                    leading: Icon(Icons.access_time),
                    title: Text(getDayName(schedules[index].dayOfWeek)),
                    subtitle: Text(
                        "${DateFormat.jm().format(DateTime.parse(schedules[index].startTime))} - ${DateFormat.jm().format(DateTime.parse(schedules[index].endTime))}"),
                  );
                },
              );
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, AddScheduleScreen.id),
          child: Icon(Icons.add)),
    );
  }
}
