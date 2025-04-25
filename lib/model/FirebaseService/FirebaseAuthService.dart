import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
      return null;
    } catch (e) {
      print('Error signing in: $e');
      Get.snackbar('Error', 'An unexpected error occurred. Please try again.');
      return null;
    }
  }

  Future<UserCredential?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
      return null;
    } catch (e) {
      print('Error creating user: $e');
      Get.snackbar('Error', 'An unexpected error occurred. Please try again.');
      return null;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar('Success', 'Password reset email sent to $email');
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
    } catch (e) {
      print('Error sending password reset email: $e');
      Get.snackbar('Error', 'An unexpected error occurred. Please try again.');
    }
  }

  Future<void> signOut() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
        print('Signed out from Google');
      }

      await FacebookAuth.instance.logOut();
      print('Signed out from Facebook');

      await _auth.signOut();
      print('Signed out from Firebase Auth');
    } catch (e) {
      print('Error signing out: $e');
      Get.snackbar('Error', 'An error occurred while signing out.');
    }
  }

  Future<void> updateUserProfile(
      {String? displayName, String? photoURL}) async {
    try {
      await _auth.currentUser?.updateDisplayName(displayName);
      await _auth.currentUser?.updatePhotoURL(photoURL);
      Get.snackbar('Success', 'Profile updated successfully');
    } catch (e) {
      print('Error updating profile: $e');
      Get.snackbar('Error', 'An error occurred while updating profile.');
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      Get.snackbar('Success', 'Signed in with Google successfully');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
      return null;
    } catch (e) {
      print('Error signing in with Google: $e');
      Get.snackbar('Error', 'An unexpected error occurred. Please try again.');
      return null;
    }
  }

  Future<UserCredential?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status != LoginStatus.success) {
        Get.snackbar('Error', 'Facebook login was canceled or failed');
        return null;
      }

      final OAuthCredential credential = FacebookAuthProvider.credential(
        result.accessToken!.token,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      Get.snackbar('Success', 'Signed in with Facebook successfully');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
      return null;
    } catch (e) {
      print('Error signing in with Facebook: $e');
      Get.snackbar('Error', 'An unexpected error occurred. Please try again.');
      return null;
    }
  }

  void _handleAuthException(FirebaseAuthException e) {
    print('Firebase Auth Exception: ${e.code} - ${e.message}');

    String errorMessage = 'An error occurred. Please try again.';

    switch (e.code) {
      case 'user-not-found':
        errorMessage = 'No user found with this email.';
        break;
      case 'wrong-password':
        errorMessage = 'Incorrect password.';
        break;
      case 'email-already-in-use':
        errorMessage = 'This email is already registered.';
        break;
      case 'weak-password':
        errorMessage = 'The password is too weak.';
        break;
      case 'invalid-email':
        errorMessage = 'The email address is invalid.';
        break;
      case 'user-disabled':
        errorMessage = 'This user account has been disabled.';
        break;
      case 'too-many-requests':
        errorMessage = 'Too many requests. Try again later.';
        break;
      case 'operation-not-allowed':
        errorMessage = 'This operation is not allowed.';
        break;
      case 'invalid-credential':
        errorMessage = 'The email or password is incorrect.';
        break;
      default:
        errorMessage = 'An error occurred: ${e.message}';
    }

    Get.snackbar('Authentication Error', errorMessage);
  }
}
