import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Navigation/routername.dart';
import '../../../../model/FirebaseService/FirebaseAuthService.dart';
import '../../../Basecontroller/basecontroller.dart';

class LoginEmailControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginEmailController());
  }
}

class LoginEmailController extends BaseController {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final TextEditingController emailController = TextEditingController();
  final RxBool isValidEmail = false.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_authService.currentUser != null) {
        Get.offAllNamed(RouterName.homescreen);
      }
    });
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  void validateEmail(String value) {
    isValidEmail.value = GetUtils.isEmail(value);
  }

  void proceedToPassword() {
    if (isValidEmail.value) {
      Get.toNamed(RouterName.loginPasswordScreen,
          arguments: emailController.text);
    } else {
      Get.snackbar(
        'Invalid Email',
        'Please enter a valid email address',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void goToSignUp() {
    Get.toNamed(RouterName.signupscreen);
  }

  Future<void> signInWithGoogle() async {
    try {
      final userCredential = await _authService.signInWithGoogle();
      if (userCredential != null) {
        Get.offAllNamed(RouterName.homescreen);
      }
    } catch (e) {
      print('Error in Google sign in: $e');
      Get.snackbar(
        'Error',
        'Failed to sign in with Google. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      final userCredential = await _authService.signInWithFacebook();
      if (userCredential != null) {
        Get.offAllNamed(RouterName.homescreen);
      }
    } catch (e) {
      print('Error in Facebook sign in: $e');
      Get.snackbar(
        'Error',
        'Failed to sign in with Facebook. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
