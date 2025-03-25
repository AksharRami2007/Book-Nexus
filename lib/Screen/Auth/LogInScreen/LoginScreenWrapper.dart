import 'package:book_nexus/Constant/assets.dart';
import 'package:book_nexus/Constant/colors.dart';
import 'package:book_nexus/Screen/Auth/LogInScreen/LoginController.dart';
import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/Screen/Widget/Custombutton/Custombutton.dart';
import 'package:book_nexus/Screen/Widget/Customtextfield/Customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Widget/CustomScafflod/CustomScaffold.dart';


class Loginscreenwrapper extends BaseView<Logincontroller> {
  const Loginscreenwrapper({super.key});

  @override
  Widget vBuilder(BuildContext context) {
    return CustomScaffold(
      title: 'Log in',
      containerHeight: 27,
      containerWidth: 95,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Customtextfield(
            name: 'Email',
            obsecuretext: false,
            onchanged: (String value) {},
            inputType: TextInputType.emailAddress,
          ),
          SizedBox(
            height: 2.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: Custombutton(
              name: 'Continue',
              onclick: () {},
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 35.w),
            child: RichText(
                text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: 'Forgot Password?',
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent))
            ])),
          )
        ],
      ),
    );
  }
}
