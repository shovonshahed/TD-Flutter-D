import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'login_screen.dart';
import 'register_screen.dart';

import '../../constants/constants.dart';
import '../../controllers/doctor_controller.dart';

class WelcomeScreen extends StatelessWidget {
  final DoctorController c = Get.put(DoctorController());
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "Language",
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                width: 18.w,
              )
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // GetWellLogoLight(),
            Text(
              "TeleDoc",
              style: TextStyle(
                  fontSize: 26.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 38.h,
            ),
            Container(
              width: 330.w,
              height: 252.h,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Image(
                image: AssetImage('assets/images/home/home.png'),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    "Welcome!",
                    style: TextStyle(
                        fontSize: 26.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    // "strings.homeQuestion",
                    "Do you want to Login/Signup now?",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 33.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            primary: Color(0xFF06122A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            minimumSize: Size(184.w, 55.h)),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 11.w,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RegisterScreen.id);
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Color(0xFF06122A),
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            minimumSize: Size(184.w, 55.h)),
                        child: Text(
                          "Signup",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 75.h,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
