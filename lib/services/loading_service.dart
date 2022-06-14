import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../constants/constants.dart';

class CustomDialog {
  static Future showLoading({String? msg}) {
    return SmartDialog.showLoading(
      msg: msg!,
      background: kPrimaryColor,
    );
  }

  static Future showToast(String msg) {
    // return SmartDialog.showToast(msg);
    return SmartDialog.showToast("", widget: CustomToast(msg));
  }

  static Future dismiss() {
    return SmartDialog.dismiss();
  }
}

class CustomToast extends StatelessWidget {
  const CustomToast(this.msg, {Key? key}) : super(key: key);

  final String msg;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(bottom: 30),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        decoration: BoxDecoration(
          color: kAccentColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          //icon
          // Container(
          //   margin: EdgeInsets.only(right: 15),
          //   child: Icon(Icons.add_moderator, color: _randomColor()),
          // ),

          //msg
          Text('$msg', style: TextStyle(color: Colors.white)),
        ]),
      ),
    );
  }

  Color _randomColor() {
    return Color.fromRGBO(
      Random().nextInt(256),
      Random().nextInt(256),
      Random().nextInt(256),
      1,
    );
  }
}
