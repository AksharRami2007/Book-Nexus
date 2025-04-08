import 'package:book_nexus/Navigation/routername.dart';
import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/model/FirebaseService/FirebaseAuthService.dart';
import 'package:book_nexus/model/FirebaseService/FirestoreUserService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupcontrollerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Signupcontroller());
  }
}

class Signupcontroller extends BaseController {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final FirestoreUserService _userService = FirestoreUserService();
  var isPasswordhidden = true.obs;
  var isLoading = false.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void togglePasswordVisiblity() {
    isPasswordhidden.value = !isPasswordhidden.value;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Validate input fields
  bool validateInputs() {
    if (nameController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your name');
      return false;
    }

    if (emailController.text.isEmpty ||
        !GetUtils.isEmail(emailController.text)) {
      Get.snackbar('Error', 'Please enter a valid email address');
      return false;
    }

    if (passwordController.text.isEmpty || passwordController.text.length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 characters');
      return false;
    }

    return true;
  }

  // Create a new user account
  Future<void> createAccount() async {
    if (!validateInputs()) return;

    isLoading.value = true;

    try {
      final UserCredential? userCredential =
          await _authService.createUserWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );

      if (userCredential != null) {
        await _authService.updateUserProfile(
          displayName: nameController.text,
        );

        bool userCreated = await _userService.createUserDocument(
          name: nameController.text,
          email: emailController.text,
        );

        if (userCreated) {
          Get.offAllNamed(RouterName.genrePreferencesScreen);
        } else {
          Get.snackbar(
            'Warning',
            'Account created but profile data could not be saved. Some features may be limited.',
            duration: Duration(seconds: 5),
          );
          Get.offAllNamed(RouterName.genrePreferencesScreen);
        }
      }
    } catch (e) {
      print('Error creating account: $e');
      Get.snackbar('Error', 'Failed to create account. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }
}
