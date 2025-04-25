import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ImagePicker _imagePicker = ImagePicker();

  String? get _currentUserId => _auth.currentUser?.uid;

  Future<File?> pickImageFromGallery() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return null;
    } catch (e) {
      print('Error picking image: $e');
      Get.snackbar('Error', 'Failed to pick image');
      return null;
    }
  }

  Future<File?> pickImageFromCamera() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return null;
    } catch (e) {
      print('Error picking image: $e');
      Get.snackbar('Error', 'Failed to pick image');
      return null;
    }
  }

  Future<String?> uploadProfilePicture(File imageFile) async {
    if (_currentUserId == null) {
      Get.snackbar('Error', 'User must be authenticated to upload profile picture');
      return null;
    }

    try {
      final Reference storageRef = _storage.ref().child('profile_pictures/$_currentUserId.jpg');

      final UploadTask uploadTask = storageRef.putFile(
        imageFile,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      final TaskSnapshot taskSnapshot = await uploadTask;
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Error uploading profile picture: $e');
      Get.snackbar('Error', 'Failed to upload profile picture');
      return null;
    }
  }

  Future<bool> deleteProfilePicture() async {
    if (_currentUserId == null) {
      Get.snackbar('Error', 'User must be authenticated to delete profile picture');
      return false;
    }

    try {
      final Reference storageRef = _storage.ref().child('profile_pictures/$_currentUserId.jpg');

      await storageRef.delete();

      return true;
    } catch (e) {
      print('Error deleting profile picture: $e');
      Get.snackbar('Error', 'Failed to delete profile picture');
      return false;
    }
  }
}