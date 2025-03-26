import 'package:book_nexus/Constant/assets.dart';
import 'package:book_nexus/Constant/colors.dart';
import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/Screen/Widget/CustomScafflod/CustomScaffold.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

import '../../../../Navigation/RouterName.dart';
import '../../../Widget/Custombutton/Custombutton.dart';
import '../../../Widget/Customtextfield/Customtextfield.dart';
import 'LoginPasswordController.dart';

class LoginPasswordScreenWrapper extends BaseView<LoginPasswordController> {
  const LoginPasswordScreenWrapper({super.key});

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
          buildProfileRow(),
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
          Custombutton(
            name: 'Continue',
            onclick: () {
              Get.toNamed(RouterName.recoverPasswordscreen);
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
        ],
      ),
    );
  }

  Widget buildTextColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Jhon Doe',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.white100Color,
            )),
        Text('john.doe@example.com',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
              color: AppColors.grey,
            ))
      ],
    );
  }

  Widget buildProfileRow() {
    return Padding(
      padding: EdgeInsets.only(left: 5.w),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                AppImages.profilePic,
                width: 18.w,
              )),
          SizedBox(
            width: 3.w,
          ),
          buildTextColumn(),
          SizedBox(
            width: 14.w,
          ),
          Image.asset(
            AppImages.checked,
            width: 9.w,
          )
        ],
      ),
    );
  }
}
