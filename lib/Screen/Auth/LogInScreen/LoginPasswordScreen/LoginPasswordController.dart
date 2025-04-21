import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Navigation/routername.dart';
import '../../../../model/FirebaseService/FirebaseAuthService.dart';
import '../../../Basecontroller/basecontroller.dart';

class LoginPasswordControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginPasswordController());
  }
}

class LoginPasswordController extends BaseController {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxBool obscurePassword = true.obs;
  late String email;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      email = Get.arguments as String;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!Get.isSnackbarOpen) {
          Get.back();
        }
      });
    }
  }

  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> signIn() async {
    if (passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your password',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;

    try {
      final UserCredential? userCredential =
          await _authService.signInWithEmailAndPassword(
        email,
        passwordController.text,
      );

      if (userCredential != null) {
        Get.offAllNamed(RouterName.homescreen);
      } else {
        Get.snackbar(
          'Authentication Failed',
          'Invalid email or password',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void goToForgotPassword() {
    Get.toNamed(RouterName.recoverPasswordscreen, arguments: email);
  }
}
