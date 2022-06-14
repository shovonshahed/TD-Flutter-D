import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../controllers/doctor_controller.dart';
import 'register_screen.dart';
import '../widgets/login_signup_background.dart';
import '../../constants/constants.dart';
import '../../services/loading_service.dart';
import '../widgets/input_fields.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final DoctorController c = Get.find();
  late TextEditingController emailController;
  late TextEditingController passwordController;

  bool hidePass = true;
  bool rememberMe = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future login() async {
    // final strings = AppLocalizations.of(context)!;
    CustomDialog.showLoading(msg: "Logging you in...");
    final email = emailController.text;
    final password = passwordController.text;
    bool login = await c.login(email, password);
    if (login) {
      CustomDialog.dismiss();
      CustomDialog.showToast("Login Successful!");
      Navigator.pushNamed(context, HomeScreen.id);
    } else {
      CustomDialog.dismiss();
      CustomDialog.showToast("Login Failed");
    }
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
                  Text(
                    "User Login",
                    style: kAppbarTextStyle,
                  )
                ],
              ),
              // GetWellLogoLight(),
              Container(
                width: 411.w,
                padding: EdgeInsets.only(
                    left: 28.w, top: 110.h, right: 28.w, bottom: 37.h),
                child: Text(
                  "Login",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: 411.w,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    // MobileNumberInput(
                    //   controller: emailController,
                    //   hint: "Phone Number",
                    //   icon: CupertinoIcons.phone,
                    //   keyboardType: TextInputType.number,
                    // ),
                    EmailInput(
                      controller: emailController,
                      hint: "Email",
                      icon: Icons.email_outlined,
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
                                    fontSize: 14.sp, color: Color(0xFF373A40)),
                                icon: Icon(
                                  CupertinoIcons.lock,
                                  color: Color(0xFF256DFF),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hidePass = !hidePass;
                                    });
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
                          ),
                          Divider(
                            thickness: 1.sp,
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.sp)),
                                value: rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    rememberMe = value!;
                                  });
                                }),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  rememberMe = !rememberMe;
                                });
                              },
                              child: Text(
                                "Remeber Me",
                                style: kBodyTextStyle3,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Forgot Password",
                          style: kBodyAccentTextStyle3,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 46.h,
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, Home.id);
                        login();
                      },
                      style: kButtonStyle,
                      child: Text(
                        "Log In",
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
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RegisterScreen.id);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don\'t have an account?",
                      style: kBodyTextStyle2,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "Signup!",
                      style: kBodyAccentTextStyle2,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
