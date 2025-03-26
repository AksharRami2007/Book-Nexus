import 'package:book_nexus/Constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BookContainer extends StatelessWidget {
  final String image;
  final String bookName;
  final String authorsName;
  // final String audioLength;

  const BookContainer({
    super.key,
    required this.image,
    required this.bookName,
    required this.authorsName,
    // required this.audioLength,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.w,
      height: 35.h,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: image.startsWith('http')
                ? Image.network(
                    image,
                    height: 25.h,
                    width: 30.w,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                        'assets/images/book_placeholder.png',
                        height: 25.h,
                        width: 30.w,
                        fit: BoxFit.cover),
                  )
                : Image.asset(
                    image,
                    height: 25.h,
                    width: 30.w,
                    fit: BoxFit.cover,
                  ),
          ),
          SizedBox(height: 1.h),
          Text(
            bookName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.white100Color,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            authorsName.isNotEmpty ? authorsName : 'Unknown Author',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.white100Color,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 1.h),
          // buildRow(),
        ],
      ),
    );
  }

  // Widget buildRow() {
  //   return Row(
  //     children: [
  //       Icon(
  //         Icons.headphones,
  //         color: AppColors.white100Color,
  //         size: 2.h,
  //       ),
  //       SizedBox(width: 1.w),
  //       if (audioLength.isNotEmpty)
  //         Text(
  //           '$audioLength/m',
  //           style: TextStyle(
  //             color: AppColors.white100Color,
  //             fontSize: 16.sp,
  //             fontWeight: FontWeight.w500,
  //           ),
  //         ),
  //     ],
  //   );
  // }
}
