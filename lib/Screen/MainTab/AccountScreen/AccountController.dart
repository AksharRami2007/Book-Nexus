import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/Screen/MainTab/ProfileDetailScreen/BookCalendarController.dart';
import 'package:book_nexus/model/Book/ReadingHistoryEntry.dart';
import 'package:book_nexus/model/FirebaseService/FirestoreBookService.dart';
import 'package:get/get.dart';

class AccountcontrollerBindings implements Bindings {
  @override
  void dependencies() {
    // Get.put(() => Accountcontroller());
    Get.put(Accountcontroller());
    // Get.lazyPut(() => BookCalendarController());
  }
}

class Accountcontroller extends BaseController {
  // Tab selection
  final RxInt selectedTabIndex = 0.obs;

  // Tab titles
  final List<String> tabTitles = ['Account', 'Reading Calendar'];

  // Reading statistics
  final RxInt totalReadingMinutes = 0.obs;
  final RxDouble totalReadingHours = 0.0.obs;
  final RxBool isLoadingStats = false.obs;

  // Services
  final FirestoreBookService _bookService = FirestoreBookService();

  @override
  void onInit() {
    super.onInit();
    loadReadingStatistics();
  }

  // Load reading statistics
  Future<void> loadReadingStatistics() async {
    isLoadingStats.value = true;

    try {
      // Get all reading history entries
      final List<ReadingHistoryEntry>? entries =
          await _bookService.getReadingHistoryEntries();

      if (entries != null && entries.isNotEmpty) {
        // Calculate total reading time in minutes
        int totalMinutes = 0;
        for (final entry in entries) {
          totalMinutes += entry.duration;
        }

        // Update observables
        totalReadingMinutes.value = totalMinutes;
        totalReadingHours.value = totalMinutes / 60.0;

        print(
            'Total reading time: ${totalReadingHours.value.toStringAsFixed(1)} hours');
      }
    } catch (e) {
      print('Error loading reading statistics: $e');
    } finally {
      isLoadingStats.value = false;
    }
  }

  // Change selected tab
  void changeTab(int index) {
    selectedTabIndex.value = index;
  }
}
