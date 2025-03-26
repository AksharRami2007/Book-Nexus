import 'package:flutter/material.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:get/get.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Constant/assets.dart';
import '../../../Constant/colors.dart';
import '../HomeSrceen/HomeController.dart';

class CustomNavBar extends StatefulWidget {
  final HomeController homeScreenController;
  final Widget child;

  const CustomNavBar({
    Key? key,
    required this.homeScreenController,
    required this.child,
  }) : super(key: key);

  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  List<String> filteredMovies = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BottomBar(
        fit: StackFit.expand,
        borderRadius: BorderRadius.circular(25),
        barColor: Colors.transparent,
        showIcon: false,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        body: (context, controller) => SafeArea(
          child: widget.child,
        ),
        width: 200.w,
        child: Padding(
          padding: EdgeInsets.only(bottom: 1.h),
          child: Container(
            height: 11.h,
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(AppImages.home, 'Home', 0),
                    _buildNavItem(AppImages.explore, 'Explore', 1),
                    _buildNavItem(AppImages.library, 'library', 2),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String imagePath, String title, int index) {
    return GestureDetector(
      onTap: () => widget.homeScreenController.changeIndex(index),
      child: Obx(
        () {
          bool isSelected =
              widget.homeScreenController.selectedIndex.value == index;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 7.w,
                height: 7.h,
                color: isSelected ? AppColors.green : Colors.grey,
              ),
              Text(
                title,
                style: TextStyle(color: isSelected ? AppColors.green :  Colors.grey),
              ),
              if (isSelected)
                Container(
                  height: 0.5.h,
                  width: 6.w,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
