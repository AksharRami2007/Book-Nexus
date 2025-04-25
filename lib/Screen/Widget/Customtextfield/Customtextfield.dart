import 'package:book_nexus/Constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Customtextfield extends StatelessWidget {
  final String name;
  final TextInputType? inputType;
  final bool obsecuretext;
  final TextEditingController? controller;
  final Widget? suffixicon;
  final Function(String)? onChanged;
  const Customtextfield(
      {Key? key,
      required this.name,
      this.inputType,
      required this.obsecuretext,
      this.controller,
      this.suffixicon,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: TextField(
        obscureText: obsecuretext,
        controller: controller,
        keyboardType: inputType,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: name,
          suffixIcon: suffixicon,
          filled: true,
          fillColor: AppColors.white100Color,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
