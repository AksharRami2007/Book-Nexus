import 'package:book_nexus/Navigation/routername.dart';
import 'package:book_nexus/model/FirebaseService/FirestoreUserService.dart';
import 'package:get/get.dart';

import '../../../model/GenreList/BookGenreList.dart';
import '../../Basecontroller/basecontroller.dart';

class GenrePreferencesControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GenrePreferencesController());
  }
}

class GenrePreferencesController extends BaseController {
  final FirestoreUserService _userService = FirestoreUserService();
  final RxList<String> categories = BookGenreList.genre.obs;
  final RxList<String> selectedCategories = <String>[].obs;
  final RxBool isExpanded = false.obs;
  final RxBool isLoading = false.obs;
  Future<void> saveGenresAndContinue() async {
    if (selectedCategories.isEmpty) {
      Get.snackbar('Error', 'Please select at least one genre');
      return;
    }

    isLoading.value = true;

    try {
      bool success =
          await _userService.saveGenrePreferences(selectedCategories);

      if (success) {
        Get.snackbar('Success', 'Your preferences have been saved');
      } else {
        Get.snackbar(
          'Warning',
          'Your preferences could not be saved, but you can continue',
          duration: Duration(seconds: 3),
        );
      }

             Get.offAllNamed(RouterName.homescreen);
    } catch (e) {
      print('Error saving genre preferences: $e');
      Get.snackbar('Error', 'Failed to save preferences. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  void toggleCategory(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    categories.addAll([
      "Fiction",
      "Novel",
      "Narrative",
      "Historical Fiction",
      "Non-fiction",
      "Mystery",
      "Horror",
      "Children’s Literature",
      "Sci-Fi",
      "Thriller",
      "Romantic",
      "History",
      "Poetry",
      "Biography",
      "Crime",
      "Autobiography",
      "Cookbook",
    ]);

    update();
  }
}
