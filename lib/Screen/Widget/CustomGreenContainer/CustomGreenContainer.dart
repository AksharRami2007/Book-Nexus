import 'package:flutter/material.dart';

import '../../../Constant/colors.dart';

class CustomeGreenContainer extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  const CustomeGreenContainer(
      {super.key,
      required this.height,
      required this.width,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors().container.withOpacity(0.7)),
      child: child,
    );
  }
}
