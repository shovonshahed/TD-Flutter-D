import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../services/loading_service.dart';
import 'login_screen.dart';
import 'dart:ui' as ui;

import '../../controllers/doctor_controller.dart';
import '../widgets/input_fields.dart';
import '../widgets/login_signup_background.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'signup_screen';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final DoctorController c = Get.find();
  late TextEditingController nameController;
  late TextEditingController mobileNumberController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  bool hidePass = true;
  bool hideConfirmPass = true;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController();
    mobileNumberController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    mobileNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  signUp() async {
    // final strings = AppLocalizations.of(context)!;
    if (_formKey.currentState!.validate()) {
      CustomDialog.showLoading(msg: "Processing Signup");
      print("valid");

      bool signup = await c.signup(nameController.text, emailController.text,
          passwordController.text, confirmPasswordController.text);
      if (signup) {
        CustomDialog.dismiss();
        CustomDialog.showToast("Sign up successful!");
        Navigator.pushNamedAndRemoveUntil(
            context, LoginScreen.id, (route) => false);
      } else {
        CustomDialog.dismiss();
        CustomDialog.showToast(
            "A user with this email already exist!\nPlease use a different email address and try again.");
      }
    } else {
      print("invalid");
    }
  }

  bool passwordValid() {
    print(passwordController.text);
    print(confirmPasswordController.text);
    return passwordController.text == confirmPasswordController.text;
  }

  @override
  Widget build(BuildContext context) {
    // final strings = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: LoginSignupBackgroundWidget(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              // LogoLight(),
              Container(
                width: 411.w,
                padding: EdgeInsets.only(
                    left: 28.w, top: 110.h, right: 28.w, bottom: 37.h),
                child: Text(
                  "Registration",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
              ),
              Form(
                key: _formKey,
                child: Container(
                  width: 411.w,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      NameInput(
                        controller: nameController,
                        hint: "Name",
                        icon: CupertinoIcons.profile_circled,
                        keyboardType: TextInputType.text,
                      ),
                      // MobileNumberInput(
                      //   controller: mobileNumberController,
                      //   hint: "Mobile Number",
                      //   icon: CupertinoIcons.phone,
                      //   keyboardType: TextInputType.number,
                      // ),
                      EmailInput(
                        controller: emailController,
                        hint: "Email",
                        icon: CupertinoIcons.mail,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0xFF373A40)),
                                  icon: Icon(
                                    CupertinoIcons.lock,
                                    color: Color(0xFF256DFF),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      print("tapped hide");
                                      hidePass = !hidePass;
                                      setState(() {});
                                    },
                                    icon: Icon(hidePass
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                  border: InputBorder.none),
                              style: TextStyle(
                                  fontSize: 14.sp, color: Color(0xFF373A40)),
                              obscureText: hidePass,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                // String pattern =
                                //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
                                // RegExp regExp = new RegExp(pattern);
                                if (value == null || value.isEmpty) {
                                  return "Password cannot be empty!";
                                }
                                // else if (!regExp.hasMatch(value)) {
                                //   return 'Password strength too weak';
                                // }
                                else if (value.length < 6) {
                                  return "Password length too small!";
                                }
                                return null;
                              },
                            ),
                            Divider(
                              thickness: 1.sp,
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: confirmPasswordController,
                              decoration: InputDecoration(
                                  hintText: "Confirm Password",
                                  hintStyle: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0xFF373A40)),
                                  icon: Icon(
                                    CupertinoIcons.lock,
                                    color: Color(0xFF256DFF),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      print("tapped hide");
                                      hideConfirmPass = !hideConfirmPass;
                                      setState(() {});
                                    },
                                    icon: Icon(hideConfirmPass
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                  border: InputBorder.none),
                              style: TextStyle(
                                  fontSize: 14.sp, color: Color(0xFF373A40)),
                              obscureText: hideConfirmPass,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if ((value == null || value.isEmpty)) {
                                  return "Please confirm your password";
                                } else if (!(passwordController.text ==
                                    confirmPasswordController.text)) {
                                  return "Passwords doesn\'t match!";
                                }
                                return null;
                              },
                            ),
                            Divider(
                              thickness: 1.sp,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 46.h,
                      ),
                      TextButton(
                        onPressed: () {
                          print("Tapped signup");
                          signUp();
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Color(0xFF50AFFF),
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            minimumSize: Size(double.infinity, 50.h)),
                        child: Text(
                          "Signup",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 46.h,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}

// class NameInput extends StatelessWidget {
//   const NameInput({
//     Key? key,
//     required this.controller,
//     required this.hint,
//     required this.icon,
//     required this.keyboardType,
//   }) : super(key: key);
//
//   final TextEditingController controller;
//   final String hint;
//   final IconData icon;
//   final TextInputType keyboardType;
//
//   @override
//   Widget build(BuildContext context) {
//     // final strings = AppLocalizations.of(context)!;
//     return Container(
//       padding: EdgeInsets.only(bottom: 8.h),
//       child: Column(
//         children: [
//           TextFormField(
//             controller: controller,
//             keyboardType: keyboardType,
//             decoration: InputDecoration(
//                 hintText: hint,
//                 hintStyle: TextStyle(fontSize: 14.sp, color: Color(0xFF373A40)),
//                 icon: Icon(
//                   icon,
//                   color: Color(0xFF256DFF),
//                 ),
//                 border: InputBorder.none),
//             style: TextStyle(fontSize: 14.sp, color: Color(0xFF373A40)),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return "strings.nameValidator";
//               }
//               return null;
//             },
//           ),
//           Divider(
//             thickness: 1.sp,
//           )
//         ],
//       ),
//     );
//   }
// }

// class MobileNumberInput extends StatelessWidget {
//   const MobileNumberInput({
//     Key? key,
//     required this.controller,
//     required this.hint,
//     required this.icon,
//     required this.keyboardType,
//   }) : super(key: key);
//
//   final TextEditingController controller;
//   final String hint;
//   final IconData icon;
//   final TextInputType keyboardType;
//
//   @override
//   Widget build(BuildContext context) {
//     // final strings = AppLocalizations.of(context)!;
//     return Container(
//       padding: EdgeInsets.only(bottom: 8.h),
//       child: Column(
//         children: [
//           TextFormField(
//             controller: controller,
//             keyboardType: keyboardType,
//             decoration: InputDecoration(
//                 hintText: hint,
//                 hintStyle: TextStyle(fontSize: 14.sp, color: Color(0xFF373A40)),
//                 icon: Icon(
//                   icon,
//                   color: Color(0xFF256DFF),
//                 ),
//                 border: InputBorder.none),
//             style: TextStyle(fontSize: 14.sp, color: Color(0xFF373A40)),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return "strings.mobileNumberValidator";
//               } else if (value.length < 11) {
//                 return "strings.mobileNumberLengthValidator";
//               }
//               return null;
//             },
//           ),
//           Divider(
//             thickness: 1.sp,
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class EmailInput extends StatelessWidget {
//   const EmailInput({
//     Key? key,
//     required this.controller,
//     required this.hint,
//     required this.icon,
//     required this.keyboardType,
//   }) : super(key: key);
//
//   final TextEditingController controller;
//   final String hint;
//   final IconData icon;
//   final TextInputType keyboardType;
//
//   @override
//   Widget build(BuildContext context) {
//     // final strings = AppLocalizations.of(context)!;
//     return Container(
//       padding: EdgeInsets.only(bottom: 8.h),
//       child: Column(
//         children: [
//           TextFormField(
//             controller: controller,
//             keyboardType: keyboardType,
//             decoration: InputDecoration(
//                 hintText: hint,
//                 hintStyle: TextStyle(fontSize: 14.sp, color: Color(0xFF373A40)),
//                 icon: Icon(
//                   icon,
//                   color: Color(0xFF256DFF),
//                 ),
//                 border: InputBorder.none),
//             style: TextStyle(fontSize: 14.sp, color: Color(0xFF373A40)),
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return "strings.emailValidator";
//               } else if (!RegExp(
//                   r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                   .hasMatch(value)) {
//                 return "strings.emailPatternValidator";
//               } else
//                 return null;
//             },
//           ),
//           Divider(
//             thickness: 1.sp,
//           )
//         ],
//       ),
//     );
//   }
// }

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * -0.00004523756, 0);
    path_0.lineTo(size.width, 0);
    path_0.cubicTo(
        size.width * 0.9987829,
        size.height * 0.2173913,
        size.width * 0.8914805,
        size.height * 0.5267559,
        size.width * 0.4719951,
        size.height * 0.5267559);
    path_0.cubicTo(
        size.width * 0.1240027,
        size.height * 0.5267559,
        size.width * 0.01652556,
        size.height * 0.8524381,
        size.width * -0.00004523488,
        size.height * 0.9634482);
    path_0.lineTo(size.width * -0.00004523488, size.height);
    path_0.cubicTo(
        size.width * -0.003017098,
        size.height,
        size.width * -0.003449488,
        size.height * 0.9862542,
        size.width * -0.00004523488,
        size.height * 0.9634482);
    path_0.lineTo(size.width * -0.00004523756, 0);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xff256DFF).withOpacity(0.1);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPS2CustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width, size.height * 0.002066116);
    path_0.lineTo(size.width * -0.00004525537, size.height * 0.002066116);
    path_0.lineTo(size.width * -0.00004525537, size.height);
    path_0.cubicTo(
        size.width * -0.00004525537,
        size.height * 0.9421488,
        size.width * 0.05251195,
        size.height * 0.6053719,
        size.width * 0.4719951,
        size.height * 0.6053719);
    path_0.cubicTo(size.width * 0.8914805, size.height * 0.6053719, size.width,
        size.height * 0.2706612, size.width, size.height * 0.002066116);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xff50AFFF).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
