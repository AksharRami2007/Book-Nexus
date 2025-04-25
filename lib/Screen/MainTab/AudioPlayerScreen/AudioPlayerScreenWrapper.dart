import 'dart:ui';
import 'package:book_nexus/Constant/assets.dart';
import 'package:book_nexus/Constant/colors.dart';
import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/Screen/MainTab/AudioPlayerScreen/AudioPlayerController.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class Audioplayerscreenwrapper extends BaseView<Audioplayercontroller> {
  const Audioplayerscreenwrapper({super.key});

  @override
  Widget vBuilder(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.black,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      // Add debounce to prevent multiple navigation actions
                      if (!Get.isSnackbarOpen) {
                        Get.back();
                      }
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 4.h,
                      color: AppColors.white100Color,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_vert_sharp,
                      size: 3.h,
                      color: AppColors.white100Color,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              SizedBox(
                height: 60.h,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                          child: Container(
                            decoration: BoxDecoration(
                              image: controller.coverImage.value.isNotEmpty
                                  ? DecorationImage(
                                      image: NetworkImage(
                                          controller.coverImage.value),
                                      fit: BoxFit.cover,
                                    )
                                  : DecorationImage(
                                      image:
                                          ExactAssetImage(AppImages.bookcover),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            child:
                                Container(color: Colors.black.withOpacity(0.4)),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 22.h,
                      left: 20.w,
                      child: Obx(() => controller.coverImage.value.isNotEmpty
                          ? Image.network(
                              controller.coverImage.value,
                              height: 35.h,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              AppImages.bookcover,
                              height: 35.h,
                            )),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1.h),
              Obx(() => Text(
                    controller.bookTitle.value,
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white100Color,
                    ),
                  )),
              SizedBox(height: 1.h),
              Obx(() => Text(
                    'By ${controller.authors.value}',
                    style: TextStyle(
                        fontSize: 15.sp, color: AppColors.white100Color),
                  )),
              SizedBox(height: 1.h),
              // Status message and alternative source button
              Obx(() => Visibility(
                    visible: !controller.isAudioAvailable.value,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              controller.statusMessage.value,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.white100Color,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Center(
                            child: ElevatedButton(
                              onPressed: () =>
                                  controller.tryAlternativeSource(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.green,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4.w, vertical: 1.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                'Try Another Source',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.white100Color,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Obx(() => Padding(
                                padding: EdgeInsets.only(top: 0.5.h),
                                child: Center(
                                  child: Text(
                                    'Current source: ${controller.currentApiSource.value}',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColors.white100Color,
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  )),
              Obx(
                () => Expanded(
                    child: SfSlider(
                        min: 0.0,
                        max: 100.0,
                        value: controller.slider.value,
                        showTicks: false,
                        activeColor: AppColors.green,
                        showLabels: false,
                        enableTooltip: true,
                        minorTicksPerInterval: 1,
                        onChanged: (dynamic value) {
                          controller.onchange(value);
                        })),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.skip_previous_outlined,
                      size: 4.h,
                      color: AppColors.white100Color,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => controller.skipBackward(),
                        icon: Icon(
                          Icons.replay_10_sharp,
                          size: 4.h,
                          color: AppColors.white100Color,
                        ),
                      ),
                      Obx(() => IconButton(
                            onPressed: () => controller.togglePlayPause(),
                            icon: Icon(
                              controller.isPlaying.value
                                  ? Icons.pause_circle_filled_sharp
                                  : Icons.play_circle_fill_sharp,
                              size: 7.h,
                              color: AppColors.green,
                            ),
                          )),
                      IconButton(
                        onPressed: () => controller.skipForward(),
                        icon: Icon(
                          Icons.forward_10_sharp,
                          size: 4.h,
                          color: AppColors.white100Color,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.skip_next_outlined,
                      size: 4.h,
                      color: AppColors.white100Color,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.dark_mode_sharp,
                      size: 3.5.h,
                      color: AppColors.white100Color,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.changeSpeed(),
                    child: Obx(() => Text(
                          '${controller.playbackSpeed.value}x',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white100Color,
                          ),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
