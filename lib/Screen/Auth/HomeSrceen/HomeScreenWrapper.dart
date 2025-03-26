import 'package:book_nexus/Constant/assets.dart';
import 'package:book_nexus/Constant/colors.dart';
import 'package:book_nexus/Screen/Auth/HomeSrceen/HomeController.dart';
import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

class Homescreenwrapper extends BaseView<Homecontroller> {
  const Homescreenwrapper({super.key});

  @override
  Widget vBuilder(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            SizedBox(height: 5.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good Afternoon',
                      style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold,color: AppColors.white100Color),
                    ),
                    Image.asset(AppImages.curv,height: 0.5.h,)
                  ],
                ),
                ClipRRect(borderRadius: BorderRadius.circular(30),
                  child: Image.asset(AppImages.profilePic,height: 6.h,))
              ],
            )
          ],
        ),
      ),
    );
  }
}
