import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:teledoc_doctor/view/screens/schedule_patients_list.dart';
import '../../controllers/doctor_controller.dart';

import '../widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';
  HomeScreen({Key? key}) : super(key: key);
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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: MyCustomAppBar(),
        drawer: SideDrawer(pageName: 'home-page'),
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
      ),
    );
  }
}

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyCustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("TeleDoc"),
      centerTitle: true,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: Icon(Icons.menu),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(70);
}
