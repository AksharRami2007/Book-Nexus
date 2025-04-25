import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/model/FirebaseService/FirebaseAuthService.dart';
import 'package:book_nexus/model/FirebaseService/FirestoreUserService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfiledetailcontrollerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Profiledetailcontroller());
  }
}

class Profiledetailcontroller extends BaseController {
  final Rx<User?> currentUser = Rx<User?>(null);
  final RxString userName = ''.obs;
  final RxString userEmail = ''.obs;
  final RxString dateOfBirth = ''.obs;
  final RxBool isLoading = false.obs;
  final RxBool isEditing = false.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  final FirebaseAuthService _authService = FirebaseAuthService();
  final FirestoreUserService _userService = FirestoreUserService();

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    dobController.dispose();
    super.onClose();
  }

  Future<void> loadUserData() async {
    isLoading.value = true;

    try {
      currentUser.value = _authService.currentUser;

      if (currentUser.value != null) {
        userEmail.value = currentUser.value!.email ?? '';

        userName.value = currentUser.value!.displayName ?? '';

        final userData = await _userService.getUserData();

        if (userData != null) {
          if (userData['name'] != null && userName.value.isEmpty) {
            userName.value = userData['name'];
          }

          if (userData['dateOfBirth'] != null) {
            dateOfBirth.value = userData['dateOfBirth'];
          }
        }

        nameController.text = userName.value;
        emailController.text = userEmail.value;
        dobController.text = dateOfBirth.value;

        print('User data loaded: ${userName.value}, ${userEmail.value}');
      }
    } catch (e) {
      print('Error loading user data: $e');
      Get.snackbar(
        'Error',
        'Failed to load user data. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void toggleEditMode() {
    isEditing.value = !isEditing.value;

    if (isEditing.value) {
      nameController.text = userName.value;
      emailController.text = userEmail.value;
      dobController.text = dateOfBirth.value;
    }
  }

  Future<void> saveUserData() async {
    if (!isEditing.value) return;

    isLoading.value = true;

    try {
      if (nameController.text != userName.value) {
        await _authService.updateUserProfile(displayName: nameController.text);
      }

      await _userService.updateUserData(
        name: nameController.text,
        photoURL: null,
      );

      userName.value = nameController.text;
      dateOfBirth.value = dobController.text;

      isEditing.value = false;

      Get.snackbar(
        'Success',
        'Profile updated successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print('Error saving user data: $e');
      Get.snackbar(
        'Error',
        'Failed to update profile. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void cancelEditing() {
    isEditing.value = false;
  }
}