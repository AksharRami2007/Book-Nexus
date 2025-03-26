import 'package:book_nexus/Constant/colors.dart';
import 'package:book_nexus/Navigation/routername.dart';
import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/Screen/Widget/CustomScafflod/CustomScaffold.dart';
import 'package:book_nexus/Screen/Widget/Custombutton/Custombutton.dart';
import 'package:book_nexus/Screen/Widget/Customtextfield/Customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

import 'VerifyCodeController.dart';

class Verifycodescreenwrapper extends BaseView<VerifyCodecontroller> {
  const Verifycodescreenwrapper({super.key});

  @override
  Widget vBuilder(BuildContext context) {
    return CustomScaffold(
        title: 'Verify Code',
        containerHeight: 28,
        containerWidth: 95,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 2.h,
            ),
            Text(
              'An Authentication Code Has Been Sent To Your Email.',
              style: TextStyle(color: AppColors.white100Color),
            ),
            SizedBox(
              height: 2.h,
            ),
            Customtextfield(
              name: 'Enter Code',
              obsecuretext: false,
              onchanged: (String value) {},
              inputType: TextInputType.name,
            ),
            SizedBox(
              height: 2.h,
            ),
            Custombutton(
              name: 'Verify',
              onclick: () {
                Get.toNamed(RouterName.setPasswordScreen);
              },
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                      text: 'Don\'t Receive a Code? ',
                      style: TextStyle(
                          fontSize: 15.sp, color: AppColors.white100Color),
                    ),
                    TextSpan(
                      text: 'Resend',
                      style: TextStyle(fontSize: 15.sp, color: AppColors.green),
                    ),
                  ]),
                ),
                Icon(
                  Icons.restart_alt,
                  color: AppColors.green,
                  size: 2.h,
                )
              ],
            )
          ],
        ));
  }
}
