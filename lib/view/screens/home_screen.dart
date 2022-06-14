import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/doctor_controller.dart';

import '../widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';
  HomeScreen({Key? key}) : super(key: key);
  final DoctorController controller = Get.find();
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
          child: Text(controller.doctor.value.name),
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
