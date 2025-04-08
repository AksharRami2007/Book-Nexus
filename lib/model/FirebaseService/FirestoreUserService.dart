import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirestoreUserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Collection references
  CollectionReference get _usersCollection => _firestore.collection('users');

  // Get current user ID
  String? get _currentUserId => _auth.currentUser?.uid;

  // Get user document reference
  DocumentReference? get _userDocRef =>
      _currentUserId != null ? _usersCollection.doc(_currentUserId) : null;

  // Create a new user document in Firestore
  Future<bool> createUserDocument({
    required String name,
    required String email,
    List<String>? favoriteGenres,
  }) async {
    if (_currentUserId == null) {
      Get.snackbar('Error', 'User must be authenticated to create profile');
      return false;
    }

    try {
      await _usersCollection.doc(_currentUserId).set({
        'uid': _currentUserId,
        'name': name,
        'email': email,
        'favoriteGenres': favoriteGenres ?? [],
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      Get.snackbar('Success', 'User profile created successfully');
      return true;
    } catch (e) {
      print('Error creating user document: $e');
      Get.snackbar('Error', 'Failed to create user profile');
      return false;
    }
  }

  // Update user data
  Future<bool> updateUserData({
    String? name,
    List<String>? favoriteGenres,
    String? photoURL,
  }) async {
    if (_currentUserId == null || _userDocRef == null) {
      Get.snackbar('Error', 'User must be authenticated to update profile');
      return false;
    }

    try {
      Map<String, dynamic> updateData = {
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if (name != null) updateData['name'] = name;
      if (favoriteGenres != null) updateData['favoriteGenres'] = favoriteGenres;
      if (photoURL != null) updateData['photoURL'] = photoURL;

      await _userDocRef!.update(updateData);

      Get.snackbar('Success', 'User profile updated successfully');
      return true;
    } catch (e) {
      print('Error updating user data: $e');
      Get.snackbar('Error', 'Failed to update user profile');
      return false;
    }
  }

  // Get user data
  Future<Map<String, dynamic>?> getUserData() async {
    if (_currentUserId == null || _userDocRef == null) {
      Get.snackbar('Error', 'User must be authenticated to get profile');
      return null;
    }

    try {
      DocumentSnapshot doc = await _userDocRef!.get();
      
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        print('User document does not exist');
        return null;
      }
    } catch (e) {
      print('Error getting user data: $e');
      Get.snackbar('Error', 'Failed to get user profile');
      return null;
    }
  }

  // Check if user document exists
  Future<bool> userDocumentExists() async {
    if (_currentUserId == null || _userDocRef == null) {
      return false;
    }

    try {
      DocumentSnapshot doc = await _userDocRef!.get();
      return doc.exists;
    } catch (e) {
      print('Error checking if user document exists: $e');
      return false;
    }
  }

  // Save user's genre preferences
  Future<bool> saveGenrePreferences(List<String> genres) async {
    return updateUserData(favoriteGenres: genres);
  }
}