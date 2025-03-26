import 'package:book_nexus/Constant/colors.dart';
import 'package:book_nexus/Navigation/routername.dart';
import 'package:book_nexus/Screen/Auth/ForgotPasswordScreen/RecoverPasswordScreen/RecoverPasswordController.dart';
import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/Screen/Widget/Custombutton/Custombutton.dart';
import 'package:book_nexus/Screen/Widget/Customtextfield/Customtextfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

import '../../../Widget/CustomScafflod/CustomScaffold.dart';

class RecoverPasswordScreenWrapper extends BaseView<RecoverPasswordController> {
  const RecoverPasswordScreenWrapper({super.key});

  @override
  Widget vBuilder(BuildContext context) {
    return CustomScaffold(
        containerHeight: 30,
        containerWidth: 95,
        title: 'Recover Password',
        isBackBtn: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Text(
                'Forgot Your Password? Don\'t Worry Enter Your Email To Reset Your Current password',
                style: TextStyle(color: AppColors.white100Color),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Customtextfield(
              name: 'Email',
              obsecuretext: false,
              inputType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 4.w),
              child: Custombutton(
                name: 'Submit',
                onclick: () {
                  Get.toNamed(RouterName.verifyCodeScreen);
                },
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: 'Don\'t Have An Account? ',
                    style: TextStyle(
                      color: AppColors.white100Color,
                      fontSize: 15.sp,
                    )),
                TextSpan(
                    text: 'Sign Up',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.toNamed(RouterName.signupscreen);
                      },
                    style: TextStyle(
                        color: AppColors.green,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold)),
              ])),
            )
          ],
        ));
  }
}
