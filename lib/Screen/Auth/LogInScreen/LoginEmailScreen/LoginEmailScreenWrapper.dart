import 'package:book_nexus/Constant/assets.dart';
import 'package:book_nexus/Constant/colors.dart';
import 'package:book_nexus/Screen/Auth/LogInScreen/LoginEmailScreen/LoginEmailController.dart';
import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/Screen/Widget/Custombutton/Custombutton.dart';
import 'package:book_nexus/Screen/Widget/Customtextfield/Customtextfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

import '../../../../Navigation/routername.dart';
import '../../../Widget/CustomScafflod/CustomScaffold.dart';

class LoginEmailScreenWrapper extends BaseView<LoginEmailController> {
  const LoginEmailScreenWrapper({super.key});

  @override
  Widget vBuilder(BuildContext context) {
    return CustomScaffold(
      title: 'Log in',
      containerHeight: 58,
      containerWidth: 95,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 3.h,
          ),
          Customtextfield(
            name: 'Email',
            obsecuretext: false,
            inputType: TextInputType.emailAddress,
          ),
          SizedBox(
            height: 2.h,
          ),
          Custombutton(
            name: 'Continue',
            onclick: () {
              Get.toNamed(RouterName.homescreen);
            },
          ),
          SizedBox(
            height: 2.h,
          ),
          RichText(
              text: TextSpan(children: <TextSpan>[
            TextSpan(
                text: 'Forgot Password?',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.toNamed(RouterName.recoverPasswordscreen);
                  },
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.green,
                ))
          ])),
          SizedBox(
            height: 4.h,
          ),
          buildDividerOrRow(),
          SizedBox(
            height: 4.h,
          ),
          buildLoginContainer(AppImages.facebook, 'Login With FaceBook'),
          SizedBox(
            height: 3.h,
          ),
          buildLoginContainer(AppImages.google, 'Login With Google'),
          SizedBox(
            height: 3.h,
          ),
          buildDoNotHaveAccountText()
        ],
      ),
    );
  }

  Widget buildDoNotHaveAccountText() {
    return RichText(
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
    ]));
  }

  Widget buildLoginContainer(String image, String title) {
    return Container(
      height: 7.h,
      width: 86.w,
      decoration: BoxDecoration(
          color: AppColors.white100Color,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              image,
              width: 7.w,
            ),
            Text(title,
                style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w800)),
            SizedBox(
              width: 5.w,
            )
          ],
        ),
      ),
    );
  }

  Widget buildDividerOrRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildDivider(),
        SizedBox(
          width: 3.w,
        ),
        Text('Or',
            style: TextStyle(
              fontSize: 18.sp,
              color: AppColors.grey,
            )),
        SizedBox(
          width: 3.w,
        ),
        buildDivider()
      ],
    );
  }

  Widget buildDivider() {
    return Container(
      height: 0.3.h,
      width: 35.w,
      decoration: BoxDecoration(color: AppColors.grey.withOpacity(0.2)),
    );
  }
}
