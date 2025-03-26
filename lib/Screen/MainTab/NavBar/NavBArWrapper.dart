import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../HomeSrceen/HomeController.dart';
import '../HomeSrceen/HomeScreenWrapper.dart';
import 'CustomNavBar.dart';

class Navbarwrapper extends StatefulWidget {
  const Navbarwrapper({super.key});

  @override
  State<Navbarwrapper> createState() => _NavbarwrapperState();
}

class _NavbarwrapperState extends State<Navbarwrapper> {
  final HomeController _homeController = Get.find<HomeController>();

  final List<Widget> _screens = [
    const HomeScreenWrapper(),
  ];

  @override
  Widget build(BuildContext context) {
    _homeController.checkKeyboardVisibility(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomNavBar(
          homeScreenController: _homeController,
          child: Obx(() => IndexedStack(
                index: _homeController.selectedIndex.value,
                children: _screens,
              )),
        ));
  }
}
