import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:teledoc_doctor/models/index.dart';
import 'package:teledoc_doctor/view/widgets/appbar.dart';

import '../../constants/constants.dart';
import '../../controllers/doctor_controller.dart';
import '../../services/loading_service.dart';
import '../widgets/drawer.dart';

class AddScheduleScreen extends StatefulWidget {
  static const String id = 'new-schedule';
  AddScheduleScreen({Key? key}) : super(key: key);

  @override
  State<AddScheduleScreen> createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  late TextEditingController patientNumberController;

  String? day;

  int? dayValue;

  TimeOfDay? startTime;
  TimeOfDay? endTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    patientNumberController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    patientNumberController.dispose();
  }

  setDay() {
    switch (dayValue) {
      case 1:
        day = "Saturday";
        break;
      case 2:
        day = "Sunday";
        break;
      case 3:
        day = "Monday";
        break;
      case 4:
        day = "Tuesday";
        break;
      case 5:
        day = "Wednesday";
        break;
      case 6:
        day = "Wednesday";
        break;
      case 7:
        day = "Friday";
        break;
    }
  }

  setStartTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != startTime) {
      setState(() {
        startTime = timeOfDay;
      });
    }
  }

  setEndTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != endTime) {
      setState(() {
        endTime = timeOfDay;
      });
    }
  }

  void save() async {
    CustomDialog.showLoading(msg: "Creating Schedule...");
    final DoctorController controller = Get.find();
    Schedule schedule = Schedule();
    schedule.dayOfWeek = dayValue!;
    schedule.startTime = "${startTime?.hour}:${startTime?.minute}:00";
    schedule.endTime = "${endTime?.hour}:${endTime?.minute}:00";
    schedule.patientLimit = int.parse(patientNumberController.text);
    bool save = await controller.addSchedule(schedule);
    if (save) {
      CustomDialog.dismiss();
      CustomDialog.showToast("Schedule added successful!");
      Navigator.pop(context);
    } else {
      CustomDialog.dismiss();
      CustomDialog.showToast("Something went wrong. Please try again later.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(title: "Add Schedule"),
      drawer: SideDrawer(pageName: 'new-schedule'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: const Text("Day of week"),
                trailing: DropdownButton(
                  key: const Key("day"),
                  value: dayValue,
                  hint: const Text("Select Day"),
                  items: const [
                    DropdownMenuItem<int>(
                      child: Text(
                        'Saturday',
                      ),
                      value: 1,
                    ),
                    DropdownMenuItem<int>(
                      child: Text(
                        'Sunday',
                      ),
                      value: 2,
                    ),
                    DropdownMenuItem<int>(
                      child: Text(
                        'Monday',
                      ),
                      value: 3,
                    ),
                    DropdownMenuItem<int>(
                      child: Text(
                        'Tuesday',
                      ),
                      value: 4,
                    ),
                    DropdownMenuItem<int>(
                      child: Text(
                        'Wednesday',
                      ),
                      value: 5,
                    ),
                    DropdownMenuItem<int>(
                      child: Text(
                        'Thursday',
                      ),
                      value: 6,
                    ),
                    DropdownMenuItem<int>(
                      child: Text(
                        'Friday',
                      ),
                      value: 7,
                    ),
                  ],
                  onChanged: (int? value) {
                    setState(() {
                      dayValue = value;
                      setDay();
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text("Start Time"),
                trailing: Text(
                    "${startTime?.hour ?? "Select start time"}:${startTime?.minute ?? ""}"),
                onTap: () => setStartTime(),
              ),
              ListTile(
                title: Text("End Time"),
                trailing: Text(
                    "${endTime?.hour ?? "Select end time"}:${endTime?.minute ?? ""}"),
                onTap: () => setEndTime(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Number of patients",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(
                      width: 60,
                      child: TextField(
                        controller: patientNumberController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.blue),
                          ),
                        ),
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 150.h, horizontal: 20.w),
                child: TextButton(
                  onPressed: () => save(),
                  style: kButtonStyle,
                  child: Text("Save"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
