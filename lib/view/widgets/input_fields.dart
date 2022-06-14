import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NameInput extends StatelessWidget {
  const NameInput({
    Key? key,
    required this.controller,
    required this.hint,
    required this.icon,
    required this.keyboardType,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(fontSize: 14.sp, color: Color(0xFF373A40)),
                icon: Icon(
                  icon,
                  color: Color(0xFF256DFF),
                ),
                border: InputBorder.none),
            style: TextStyle(fontSize: 14.sp, color: Color(0xFF373A40)),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          Divider(
            thickness: 1.sp,
          )
        ],
      ),
    );
  }
}

class MobileNumberInput extends StatelessWidget {
  const MobileNumberInput({
    Key? key,
    required this.controller,
    required this.hint,
    required this.icon,
    required this.keyboardType,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(fontSize: 14.sp, color: Color(0xFF373A40)),
                icon: Icon(
                  icon,
                  color: Color(0xFF256DFF),
                ),
                border: InputBorder.none),
            style: TextStyle(fontSize: 14.sp, color: Color(0xFF373A40)),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your mobile number';
              } else if (value.length < 11) {
                return 'Mobile number length too small';
              }
              return null;
            },
          ),
          Divider(
            thickness: 1.sp,
          )
        ],
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({
    Key? key,
    required this.controller,
    required this.hint,
    required this.icon,
    required this.keyboardType,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(fontSize: 14.sp, color: Color(0xFF373A40)),
                icon: Icon(
                  icon,
                  color: Color(0xFF256DFF),
                ),
                border: InputBorder.none),
            style: TextStyle(fontSize: 14.sp, color: Color(0xFF373A40)),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              } else if (!RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value)) {
                return 'Please enter a valid email';
              } else
                return null;
            },
          ),
          Divider(
            thickness: 1.sp,
          )
        ],
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    Key? key,
    required this.controller,
    required this.hint,
    required this.icon,
    required this.hide,
    required this.onTap,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool hide;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(fontSize: 14.sp, color: Color(0xFF373A40)),
                icon: Icon(
                  icon,
                  color: Color(0xFF256DFF),
                ),
                suffixIcon: IconButton(
                  onPressed: () => onTap,
                  icon: Icon(hide ? Icons.visibility : Icons.visibility_off),
                ),
                border: InputBorder.none),
            style: TextStyle(fontSize: 14.sp, color: Color(0xFF373A40)),
            obscureText: hide,
            keyboardType: TextInputType.visiblePassword,
          ),
          Divider(
            thickness: 1.sp,
          )
        ],
      ),
    );
  }
}
