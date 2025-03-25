import 'package:book_nexus/Constant/colors.dart';
import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/Screen/Widget/CustomScafflod/CustomScaffold.dart';
import 'package:flutter/material.dart';

import 'VerifyCodeController.dart';

class Signupscreenwrapper extends BaseView<VerifyCodecontroller> {
  const Signupscreenwrapper({super.key});

  @override
  Widget vBuilder(BuildContext context) {
    return CustomScaffold(
        title: 'Sign Up',
        containerHeight: 30,
        containerWidth: 95,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Looks Like You Don\'t Have An Account',
              style: TextStyle(color: AppColors().white100Color),
            ),
            Text(
              'Let\'s ',
              style: TextStyle(color: AppColors().white100Color),
            ),
          ],
        ));
  }
}
