import 'package:book_nexus/Constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Custombutton extends StatelessWidget {
  final String name;
  final VoidCallback? onclick;
  final double height;
  final double width;
  const Custombutton(
      {super.key,
      required this.name,
      this.onclick,
      this.height = 5.5,
      this.width = 86});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
            color:AppColors.green, borderRadius: BorderRadius.circular(10)),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: AppColors.green,),
            onPressed: onclick,
            child: Text(
              name,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            )));
  }
}
