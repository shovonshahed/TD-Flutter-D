import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
// import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:teledoc_doctor/controllers/doctor_controller.dart';
import 'package:teledoc_doctor/models/index.dart';
import 'package:teledoc_doctor/models/mapLocation.dart';
import 'package:teledoc_doctor/services/loading_service.dart';
import 'package:teledoc_doctor/view/screens/profile_screen.dart';
import '../../constants/constants.dart';
import '../../models/patient.dart';
import '../widgets/drawer.dart';

class ProfileEditScreen extends StatefulWidget {
  static const String id = 'profile_edit_screen';

  ProfileEditScreen({Key? key}) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final DoctorController controller = Get.find();
  late TextEditingController nameController;
  late TextEditingController mobileNumberController;
  late TextEditingController emailController;
  late TextEditingController specialityController;
  late TextEditingController collegeController;
  late TextEditingController addressController;
  MapLocation? mapLocation;
  final _formKey = GlobalKey<FormState>();
  DateTime dateOfBirth = DateTime.now();
  String? gender;
  int? genderValue;

  setGenderValue() {
    if (gender == "Male") {
      genderValue = 1;
    } else if (gender == "Female") {
      genderValue = 2;
    } else if (gender == "Transgender") {
      genderValue = 3;
    }
  }

  setGender() {
    if (genderValue == 1) {
      gender = "Male";
    } else if (genderValue == 2) {
      gender = "Female";
    } else if (genderValue == 3) {
      gender = "Transgender";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  initialize() {
    final user = controller.doctor.value;
    nameController = TextEditingController(text: user.name);
    mobileNumberController = TextEditingController(text: user.phoneNumber);
    emailController = TextEditingController(text: user.email);
    specialityController = TextEditingController(text: user.speciality ?? "");
    collegeController = TextEditingController(text: user.college ?? "");
    addressController = TextEditingController(text: user.address ?? "");
    mapLocation = user.mapLocation;
    gender = user.gender ?? "";
    dateOfBirth = DateTime.tryParse(user.dateOfBirth!) ?? DateTime.now();
    if (dateOfBirth.isBefore(DateTime(1900))) {
      dateOfBirth = DateTime(1900);
    }
    setGenderValue();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    mobileNumberController.dispose();
    emailController.dispose();
    specialityController.dispose();
    collegeController.dispose();
    addressController.dispose();
  }

  void update() async {
    if (_formKey.currentState!.validate()) {
      CustomDialog.showLoading(msg: "Updating Profile...");
      Doctor doctor = controller.doctor.value;
      doctor.name = nameController.text;
      doctor.email = emailController.text;
      doctor.phoneNumber = mobileNumberController.text;
      doctor.speciality = specialityController.text;
      doctor.college = collegeController.text;
      doctor.address = addressController.text;
      doctor.gender = gender;
      doctor.dateOfBirth = dateOfBirth.toIso8601String();
      doctor.mapLocation = mapLocation;
      bool update = await controller.updateProfile(doctor);
      if (update) {
        CustomDialog.dismiss();
        CustomDialog.showToast("Profile update successful!");
        Navigator.popAndPushNamed(context, ProfileScreen.id);
      } else {
        CustomDialog.dismiss();
        CustomDialog.showToast("Something went wrong. Please try again later.");
      }
    }
  }

  Future<Position> getGeolocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("location service not enabled");
      serviceEnabled = await Geolocator.openLocationSettings();
      if (!serviceEnabled) {
        print("location service settings denied");
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        return Future.error('Location services are disabled.');
      }
    }
    print("location service enabled");

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      print("location service permission denied");
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("location service permission denied 2nd time");
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    print("location service all permission granted");
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideDrawer(pageName: 'profile-edit'),
        appBar: AppBar(
          title: Text(
            "Edit Profile",
            style: kAppbarTextStyle.copyWith(color: kColorDarker),
          ),
          leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: kColorDarker,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              // margin: EdgeInsets.only(top: 47.h),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Profile Information",
                          style: kBodyTextStyle,
                        ),
                      ],
                    ),
                    ProfileFieldWidget(
                      title: "Name",
                      controller: nameController,
                      icon: CupertinoIcons.profile_circled,
                    ),
                    ProfileFieldWidget(
                      title: "Email",
                      controller: emailController,
                      icon: CupertinoIcons.mail,
                    ),
                    ProfileFieldWidget(
                      title: "Mobile Number",
                      controller: mobileNumberController,
                      icon: CupertinoIcons.phone,
                    ),
                    ProfileFieldWidget(
                      title: "Speciality",
                      controller: specialityController,
                      icon: CupertinoIcons.star,
                    ),
                    ProfileFieldWidget(
                      title: "College",
                      controller: collegeController,
                      icon: CupertinoIcons.book,
                    ),
                    Stack(
                      children: [
                        ProfileFieldWidget(
                          title: "Address",
                          controller: addressController,
                          icon: CupertinoIcons.mail,
                        ),
                        Positioned(
                          right: 0,
                          top: 20,
                          child: InkWell(
                            onTap: () async {
                              final position = await getGeolocation();
                              mapLocation = MapLocation();
                              mapLocation?.latitude =
                                  position.latitude.toString();
                              mapLocation?.longitude =
                                  position.longitude.toString();
                              setState(() {});
                            },
                            child: Text(
                              "Get Device Location",
                              style: kBodyTextStyle3.copyWith(
                                  color: (mapLocation != null)
                                      ? Colors.green
                                      : kAccentColor),
                            ),
                          ),
                        )
                      ],
                    ),

                    Container(
                      padding: EdgeInsets.only(top: 30.h, bottom: 10.h),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: kColorLiter,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                CupertinoIcons.profile_circled,
                                color: kPrimaryColor,
                                size: 20.w,
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Text(
                                "Gender",
                                style: kBodyTextStyle,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 40.w,
                              ),
                              DropdownButton(
                                key: Key("gender"),
                                value: genderValue,
                                hint: Text("Gender"),
                                items: [
                                  DropdownMenuItem<int>(
                                    child: Text(
                                      'Male',
                                      style: TextStyle(
                                          fontSize: 14.sp, color: kColorLite),
                                    ),
                                    value: 1,
                                  ),
                                  DropdownMenuItem<int>(
                                    child: Text(
                                      'Female',
                                      style: TextStyle(
                                          fontSize: 14.sp, color: kColorLite),
                                    ),
                                    value: 2,
                                  ),
                                  DropdownMenuItem<int>(
                                    child: Text(
                                      'Transgender',
                                      style: TextStyle(
                                          fontSize: 14.sp, color: kColorLite),
                                    ),
                                    value: 3,
                                  ),
                                ],
                                onChanged: (int? value) {
                                  setState(() {
                                    genderValue = value;
                                    setGender();
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    GestureDetector(
                      onTap: () async {
                        DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: dateOfBirth,
                            firstDate: DateTime(1900),
                            lastDate:
                                DateTime.now().subtract(Duration(days: 8760)));
                        if (newDate == null) return;
                        setState(() => dateOfBirth = newDate);
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 30.h, bottom: 10.h),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: kColorLiter,
                            ),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  CupertinoIcons.calendar,
                                  color: kPrimaryColor,
                                  size: 20.w,
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Text(
                                  "Date of Birth",
                                  style: kBodyTextStyle,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 40.w,
                                ),
                                Container(
                                  width: 339.w,
                                  height: 36.w,
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    "${DateFormat.yMMMMd().format(dateOfBirth)}",
                                    style: TextStyle(
                                        fontSize: 14.sp, color: kColorLite),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // ProfileFieldWidget(
                    //   title: "Address",
                    //   value: "House 40, Road 7, Bloc c, Banasree",
                    //   icon: CupertinoIcons.location,
                    // ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 50.h),
                      child: TextButton(
                        onPressed: () async {
                          update();
                          // await _determinePosition().then((value) {
                          //   print("lat: ${value.latitude}");
                          //   print("long: ${value.longitude}");
                          // });
                        },
                        style: kButtonStyle,
                        child: Text("Save"),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )));
  }
}

class ProfileFieldWidget extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final IconData icon;

  const ProfileFieldWidget({
    Key? key,
    required this.title,
    required this.controller,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30.h, bottom: 10.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: kColorLiter,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: kPrimaryColor,
                size: 20.w,
              ),
              SizedBox(
                width: 20.w,
              ),
              Text(
                title,
                style: kBodyTextStyle,
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 40.w,
              ),
              Container(
                alignment: Alignment.center,
                width: 339.w,
                height: 36.w,
                child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10)),
                  style: TextStyle(fontSize: 14.sp, color: kColorLite),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field cannot be empty";
                    }
                    return null;
                  },
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
