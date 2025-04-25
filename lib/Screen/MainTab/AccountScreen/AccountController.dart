import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:book_nexus/Navigation/routername.dart';
import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/Screen/MainTab/ProfileDetailScreen/BookCalendarController.dart';
import 'package:book_nexus/model/Book/ReadingHistoryEntry.dart';
import 'package:book_nexus/model/FirebaseService/FirebaseAuthService.dart';
import 'package:book_nexus/model/FirebaseService/FirebaseStorageService.dart';
import 'package:book_nexus/model/FirebaseService/FirestoreBookService.dart';
import 'package:book_nexus/model/FirebaseService/FirestoreUserService.dart';

class AccountcontrollerBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Accountcontroller());
  }
}

class Accountcontroller extends BaseController {
  final RxInt selectedTabIndex = 0.obs;

  final List<String> tabTitles = ['Account', 'Reading Calendar'];

  final RxInt totalReadingMinutes = 0.obs;
  final RxDouble totalReadingHours = 0.0.obs;
  final RxBool isLoadingStats = false.obs;
  final RxString userName = 'Loading...'.obs;
  final RxString userEmail = 'Loading...'.obs;
  final RxString profilePictureUrl = ''.obs;
  final RxBool isLoadingUserData = false.obs;
  final RxBool isUploadingImage = false.obs;

  final FirestoreBookService _bookService = FirestoreBookService();
  final FirestoreUserService _userService = FirestoreUserService();
  final FirebaseStorageService _storageService = FirebaseStorageService();
  final FirebaseAuthService _authService = FirebaseAuthService();

  @override
  void onInit() {
    super.onInit();
    loadReadingStatistics();
    loadUserData();
  }

  Future<void> loadUserData() async {
    isLoadingUserData.value = true;

    try {
      if (_authService.currentUser == null) {
        print('User is not authenticated');
        return;
      }

      final userData = await _userService.getUserData();

      if (userData != null) {
        userName.value = userData['name'] ?? 'Unknown User';
        userEmail.value = userData['email'] ?? 'No Email';
        profilePictureUrl.value = userData['photoURL'] ?? '';
      } else {
        print('User data not found');
      }
    } catch (e) {
      print('Error loading user data: $e');
    } finally {
      isLoadingUserData.value = false;
    }
  }

  Future<void> uploadProfilePicture() async {
    try {
      final ImageSource? source = await showImageSourceDialog();
      if (source == null) return;

      isUploadingImage.value = true;

      File? imageFile;
      if (source == ImageSource.gallery) {
        imageFile = await _storageService.pickImageFromGallery();
      } else {
        imageFile = await _storageService.pickImageFromCamera();
      }

      if (imageFile == null) {
        isUploadingImage.value = false;
        return;
      }

      final String? downloadUrl =
          await _storageService.uploadProfilePicture(imageFile);

      if (downloadUrl != null) {
        await _userService.updateUserData(photoURL: downloadUrl);

        profilePictureUrl.value = downloadUrl;

        Get.snackbar(
          'Success',
          'Profile picture updated successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('Error uploading profile picture: $e');
      Get.snackbar(
        'Error',
        'Failed to upload profile picture',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isUploadingImage.value = false;
    }
  }

  Future<ImageSource?> showImageSourceDialog() async {
    return await Get.dialog<ImageSource>(
      AlertDialog(
        title: Text('Select Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'),
              onTap: () => Get.back(result: ImageSource.gallery),
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Camera'),
              onTap: () => Get.back(result: ImageSource.camera),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loadReadingStatistics() async {
    isLoadingStats.value = true;

    try {
      final List<ReadingHistoryEntry>? entries =
          await _bookService.getReadingHistoryEntries();

      if (entries != null && entries.isNotEmpty) {
        int totalMinutes = 0;
        for (final entry in entries) {
          totalMinutes += entry.duration;
        }

        totalReadingMinutes.value = totalMinutes;
        totalReadingHours.value = totalMinutes / 60.0;

        print(
            'Total reading time: ${totalReadingHours.value.toStringAsFixed(1)} hours');
      }
    } catch (e) {
      print('Error loading reading statistics: $e');
    } finally {
      isLoadingStats.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await _authService.signOut();
      Get.offAllNamed(RouterName.loginEmailScreen);
    } catch (e) {
      print('Error during logout: $e');
      Get.snackbar(
        'Error',
        'Failed to logout. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }
}
