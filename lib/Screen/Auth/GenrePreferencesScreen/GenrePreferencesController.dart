import 'package:get/get.dart';

import '../../Basecontroller/basecontroller.dart';


class GenrePreferencesControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GenrePreferencesController());
  }
}

class GenrePreferencesController extends BaseController {
  final categories = <String>[].obs;
  var selectedCategories = <String>[].obs;

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
