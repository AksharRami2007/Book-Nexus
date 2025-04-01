import 'package:book_nexus/Constant/assets.dart';
import 'package:book_nexus/Constant/colors.dart';
import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/Screen/MainTab/ExploreScreen/ExploreController.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Constant/font_family.dart';
import '../../Widget/BuildRowList/buildRowList.dart';
import '../../Widget/BookShimmer/ListViewBookShimmer/BookShimmer.dart';

class ExploreScreenWrapper extends BaseView<ExploreController> {
  const ExploreScreenWrapper({super.key});

  @override
  Widget vBuilder(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),
              buildSearchBar(),
              SizedBox(height: 2.h),
              buildTopicFilters(),
              SizedBox(height: 2.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        switch (controller.selectedTopicIndex.value) {
                          case 0:
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildFictionBookList(),
                                buildCultureBookList(),
                                buildLifestyleBookList(),
                                buildRomanceBookList(),
                                buildThrillerBookList(),
                                buildSciFiBookList(),
                              ],
                            );
                          case 1:
                            return buildCultureBookList();
                          case 2:
                            return buildLifestyleBookList();
                          case 3:
                            return buildRomanceBookList();
                          case 4:
                            return buildSciFiBookList();
                          case 5:
                            return buildThrillerBookList();
                          default:
                            return SizedBox();
                        }
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearchBar() {
    return Container(
      height: 6.h,
      decoration: BoxDecoration(
        color: AppColors.bgshade,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller.searchController,
        style: TextStyle(color: AppColors.white100Color),
        decoration: InputDecoration(
          hintText: 'Search for books, authors...',
          hintStyle: TextStyle(color: AppColors.grey),
          prefixIcon: Icon(Icons.search, color: AppColors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 1.5.h),
        ),
        onChanged: controller.setSearchQuery,
      ),
    );
  }

  Widget buildTopicFilters() {
    return SizedBox(
        height: 5.h,
        child: Obx(() => ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.topics.length,
              itemBuilder: (context, index) {
                final isSelected = controller.selectedTopicIndex.value == index;
                return GestureDetector(
                  onTap: () => controller.selectTopic(index),
                  child: Container(
                    margin: EdgeInsets.only(right: 2.w),
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.green : AppColors.bgshade,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        controller.topics[index],
                        style: TextStyle(
                          color: isSelected
                              ? AppColors.white100Color
                              : AppColors.grey,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              },
            )));
  }

  Widget buildFictionBookList() {
    return BuildRowBookList(
      title: 'Fiction',
      books: controller.fictionBooks,
    );
  }

  Widget buildCultureBookList() {
    return BuildRowBookList(
      title: 'Culture & Society',
      books: controller.cultureBooks,
    );
  }

  Widget buildLifestyleBookList() {
    return BuildRowBookList(
      title: 'Life Style',
      books: controller.lifestyleBooks,
    );
  }

  Widget buildRomanceBookList() {
    return BuildRowBookList(
      title: 'Romance',
      books: controller.romanceBooks,
    );
  }

  Widget buildSciFiBookList() {
    return BuildRowBookList(
      title: 'Sci-Fi',
      books: controller.scifiBooks,
    );
  }

  Widget buildThrillerBookList() {
    return BuildRowBookList(
      title: 'Thriller',
      books: controller.thrillerBooks,
    );
  }

  TextStyle buildSectionTitleTextStyle() => TextStyle(
        fontSize: 20.sp,
        fontFamily: AppFonts.family2Bold,
        fontWeight: FontWeight.bold,
        color: AppColors.white100Color,
      );
}
