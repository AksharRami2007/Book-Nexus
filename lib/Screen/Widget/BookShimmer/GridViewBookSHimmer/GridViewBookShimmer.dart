import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';


class GridViewBookShimmer extends StatelessWidget {
  const GridViewBookShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.60,
              mainAxisSpacing: 1.h),
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
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
          }),
    );
  }
}
