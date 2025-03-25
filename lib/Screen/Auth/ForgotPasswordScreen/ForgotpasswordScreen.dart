import 'dart:ffi';

import 'package:book_nexus/Constant/assets.dart';
import 'package:book_nexus/Constant/colors.dart';
import 'package:book_nexus/Screen/Widget/CustomGreenContainer/CustomGreenContainer.dart';
import 'package:book_nexus/Screen/Widget/Customtextfield/Customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Forgotpasswordscreen extends StatelessWidget {
  const Forgotpasswordscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  AppImages.bgimage,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25.h,
                  ),
                  Text(
                    'Recover Password',
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors().white100Color),
                  ),
                  CustomeGreenContainer(
                      height: 30.h, width: 95.w, child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Forgot Your Password? Don\'t Worry Enter Your Email To Reset Your Current password',style: TextStyle(color: AppColors().white100Color),
                          ),
                          Customtextfield(name: 'Email', obsecuretext: false, onchanged: (String value){})
                        ],
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
