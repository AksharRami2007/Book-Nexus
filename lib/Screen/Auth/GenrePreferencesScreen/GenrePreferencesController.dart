import 'package:get/get.dart';

import '../../Basecontroller/basecontroller.dart';

class GenrePreferencesControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GenrePreferencesController());
  }
}

class GenrePreferencesController extends BaseController {
  final RxList<String> categories = [
    'Fiction',
    'Novel',
    'Narrative',
    'Historical Fiction',
    'Non-fiction',
    'Mystery',
    'Horror',
    'Children’s Literature',
    'Thriller',
    'Sci-Fi',
    'Romantic',
    'History',
    'Poetry',
    'Biography',
    'Crime',
    'Autobiography',
    'Cookbook'
  ].obs;
  final RxList<String> selectedCategories = <String>[].obs;
  final RxBool isExpanded = false.obs;

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
