import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const Color kPrimaryColor = Color(0xFF50AFFF);
const Color kAccentColor = Color(0xFFF16C20);
const Color kColorLite = Color(0xFFA5A5A5);
const Color kColorLiter = Color(0xFFE5E5E5);
const Color kColorDark = Color(0xFF393E46);
const Color kColorDarker = Color(0xFF06122A);

var kAppbarTextStyle = TextStyle(fontSize: 16.sp, color: Colors.white);
var kAppbarTextStyle2 = TextStyle(
    fontSize: 16.sp, fontWeight: FontWeight.bold, color: kColorDarker);
var kBodyTextStyle =
    TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: kColorDark);
var kBodyLargeTextStyle = TextStyle(
  fontSize: 18.sp,
  fontWeight: FontWeight.bold,
);
var kBodyTextStyle2 = TextStyle(fontSize: 14.sp, color: kColorDark);
var kBodyTextStyle3 = TextStyle(fontSize: 13.sp, color: Colors.black54);
var kBodyAccentTextStyle = TextStyle(
    fontSize: 16.sp, fontWeight: FontWeight.bold, color: kAccentColor);
var kBodyAccentTextStyle2 = TextStyle(
    fontSize: 14.sp, fontWeight: FontWeight.bold, color: kAccentColor);
var kBodyAccentTextStyle3 = TextStyle(
    fontSize: 13.sp, fontWeight: FontWeight.bold, color: kAccentColor);

var kButtonStyle = TextButton.styleFrom(
    backgroundColor: kPrimaryColor,
    primary: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
    minimumSize: Size(double.infinity, 50.h));
var kButtonStyleOutlined = TextButton.styleFrom(
    backgroundColor: Colors.white,
    primary: kColorDarker,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: BorderSide(color: kAccentColor, width: 1.0)),
    minimumSize: Size(double.infinity, 50.h));
var kCancelButtonStyle = TextButton.styleFrom(
    backgroundColor: kColorDarker,
    primary: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
    minimumSize: Size(double.infinity, 50.h));
