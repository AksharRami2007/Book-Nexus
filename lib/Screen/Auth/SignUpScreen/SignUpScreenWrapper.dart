import 'package:book_nexus/Constant/colors.dart';
import 'package:book_nexus/Screen/Auth/SignUpScreen/SignUpController.dart';
import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/Screen/Widget/CustomScafflod/CustomScaffold.dart';
import 'package:book_nexus/Screen/Widget/Custombutton/Custombutton.dart';
import 'package:book_nexus/Screen/Widget/Customtextfield/Customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

class Signupscreenwrapper extends BaseView<Signupcontroller> {
  const Signupscreenwrapper({super.key});

  @override
  Widget vBuilder(BuildContext context) {
    return CustomScaffold(
        title: 'Sign Up',
        containerHeight: 55,
        containerWidth: 95,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 3.h,
            ),
            Text(
              'Looks Like You Don\'t Have An Account',
              style: TextStyle(color: AppColors.white100Color),
            ),
            Text(
              'Let\'s Create a New Account For You',
              style: TextStyle(color: AppColors.white100Color),
            ),
            SizedBox(
              height: 2.h,
            ),
            Customtextfield(
              name: 'Name',
              obsecuretext: false,
              onchanged: (String value) {},
              inputType: TextInputType.name,
            ),
            SizedBox(
              height: 2.h,
            ),
            Customtextfield(
              name: 'Email',
              obsecuretext: false,
              onchanged: (String value) {},
              inputType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 2.h,
            ),
            Obx(
              () => Customtextfield(
                  name: 'Password',
                  obsecuretext: controller.isPasswordhidden.value,
                  onchanged: (String value) {
                   
                  },
                  inputType: TextInputType.visiblePassword,
                  suffixicon: IconButton(
                      onPressed: () {
                        controller.togglePasswordVisiblity();
                      },
                      icon: Icon(controller.isPasswordhidden.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined))),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              'By Selecting Create Account Below, I Agree To',
              style: TextStyle(fontSize: 15.sp, color: AppColors.white100Color),
            ),
            RichText(
                text: TextSpan(children: <TextSpan>[
              TextSpan(
                text: 'Terms Of Services & Privacy Policy',
                style: TextStyle(
                    fontSize: 15.sp,
                    color: AppColors.green,
                    fontWeight: FontWeight.bold),
              )
            ])),
            SizedBox(
              height: 2.h,
            ),
            Custombutton(
              name: 'Create Account',
              onclick: () {},
            ),
            SizedBox(
              height: 3.h,
            ),
            RichText(
                text: TextSpan(children: <TextSpan>[
              TextSpan(
                text: 'Already Have An Account? ',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: AppColors.white100Color,
                ),
              ),
              TextSpan(
                text: 'Log In',
                style: TextStyle(
                    fontSize: 15.sp,
                    color: AppColors.green,
                    fontWeight: FontWeight.bold),
              )
            ])),
          ],
        ));
  }
}
