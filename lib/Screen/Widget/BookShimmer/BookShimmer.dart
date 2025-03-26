import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart'; 

class BookListShimmer extends StatelessWidget {
  const BookListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5, // Placeholder count
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 2.h),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[850]!,
              highlightColor: Colors.grey[700]!,
              child: Container(
                width: 25.w,
                height: 38.h,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
