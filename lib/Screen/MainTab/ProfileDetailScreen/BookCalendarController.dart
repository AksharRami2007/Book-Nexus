import 'package:book_nexus/model/Book/ReadingHistoryEntry.dart';
import 'package:book_nexus/model/FirebaseService/FirestoreBookService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class BookCalendarController extends GetxController {
  final FirestoreBookService _bookService = FirestoreBookService();

  final Rx<DateTime> focusedDay = DateTime.now().obs;
  final Rx<DateTime> selectedDay = DateTime.now().obs;
  final RxMap<DateTime, List<ReadingHistoryEntry>> events =
      RxMap<DateTime, List<ReadingHistoryEntry>>({});
  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;

  final Rx<ReadingHistoryEntry?> selectedEvent = Rx<ReadingHistoryEntry?>(null);

  @override
  void onInit() {
    super.onInit();
    loadReadingHistory();
  }

  Future<void> loadReadingHistory() async {
    isLoading.value = true;
    hasError.value = false;

    try {
      final entries = await _bookService.getReadingHistoryEntries();

      if (entries != null) {
        final Map<DateTime, List<ReadingHistoryEntry>> eventMap = {};

        for (final entry in entries) {
          final date = DateTime(
            entry.readDate.toDate().year,
            entry.readDate.toDate().month,
            entry.readDate.toDate().day,
          );

          if (eventMap[date] == null) {
            eventMap[date] = [];
          }

          eventMap[date]!.add(entry);
        }

        events.value = eventMap;
        print('Loaded ${entries.length} reading history entries');
      } else {
        print('No reading history entries found');
      }

      isLoading.value = false;
    } catch (e) {
      print('Error loading reading history: $e');
      hasError.value = true;
      errorMessage.value = 'Error loading reading history: $e';
      isLoading.value = false;
    }
  }

  List<ReadingHistoryEntry> getEventsForDay(DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    return events[normalizedDay] ?? [];
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay.value = selectedDay;
    this.focusedDay.value = focusedDay;

    selectedEvent.value = null;
  }

  void onEventSelected(ReadingHistoryEntry event) {
    selectedEvent.value = event;
  }

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  // Calculate total reading duration for a specific day in hours and minutes
  String getTotalReadingTimeForDay(DateTime day) {
    final events = getEventsForDay(day);
    int totalMinutes = 0;

    for (final event in events) {
      totalMinutes += event.duration;
    }

    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;

    if (hours > 0) {
      return '$hours hr ${minutes > 0 ? '$minutes min' : ''}';
    } else if (minutes > 0) {
      return '$minutes min';
    } else {
      return '0 min';
    }
  }
}
