import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../services/loading_service.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/welcome_screen.dart';

import '../../constants/constants.dart';
import '../../controllers/doctor_controller.dart';
import '../screens/profile_screen.dart';

enum DeviceType { Phone, Tablet }

DeviceType getDeviceType() {
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
  return data.size.shortestSide < 550 ? DeviceType.Phone : DeviceType.Tablet;
}

class SideDrawer extends StatelessWidget {
  SideDrawer({
    Key? key,
  }) : super(key: key);
  final DoctorController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    // print("text scale: ${MediaQuery.of(context).textScaleFactor}");
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Container(
        color: kPrimaryColor,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: MediaQuery.of(context).padding.top,
              color: Color(0xFF06122A),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, ProfileScreen.id);
              },
              child: Container(
                height: 80.w,
                // width: 500.w,
                decoration: BoxDecoration(
                  color: Color(0xFF06122A),
                ),
                padding: EdgeInsets.only(
                  left: 16.w,
                ),
                child: Row(
                  children: [
                    Container(
                      width: (getDeviceType() == DeviceType.Tablet)
                          ? 122.w
                          : 220.w,
                      child: Text(
                        controller.doctor.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home_outlined,
                color: Colors.white,
              ),
              title: Text(
                "Home",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Navigator.pushNamed(context, HomeScreen.id),
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () async {
                CustomDialog.showLoading(msg: "Logging Out");
                bool logout = await controller.logout();
                if (logout) {
                  CustomDialog.dismiss();
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.id, (route) => false);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
