import 'package:book_nexus/Constant/colors.dart';
import 'package:book_nexus/Screen/Widget/CustomScafflod/CustomScaffold.dart';
import 'package:book_nexus/Screen/Widget/Custombutton/Custombutton.dart';
import 'package:book_nexus/Screen/Widget/Customtextfield/Customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Signupscreenwrapper extends StatelessWidget {
  const Signupscreenwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: 'Sign Up',
        containerHeight: 55,
        containerWidth: 95,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 3.h,
            ),
            Padding(
              padding:  EdgeInsets.only(right: 25.w),
              child: Text(
                'Looks Like You Don\'t Have An Account',
                style: TextStyle(color: AppColors().white100Color),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(right: 29.w),
              child: Text(
                'Let\'s Create a new Account For You',
                style: TextStyle(color: AppColors().white100Color),
              ),
            ),
            SizedBox(
              height: 3.h,
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
            Customtextfield(
              name: 'Password',
              obsecuretext: true,
              onchanged: (String value) {},
              inputType: TextInputType.visiblePassword,
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding:  EdgeInsets.only(right: 10.w),
              child: Text(
                'By Selecting Create Account Below, I Agree To',
                style:
                    TextStyle(fontSize: 15.sp, color: AppColors().white100Color),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(right: 29.w),
              child: RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: 'Terms Of Services & Privacy Policy',
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColors.green,
                        fontWeight: FontWeight.w500))
              ])),
            ),
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
                    color: AppColors().white100Color,
                  )),
              TextSpan(
                  text: 'Log In',
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: AppColors.green,
                      fontWeight: FontWeight.w500)),
            ])),
          ],
        ));
  }
}
