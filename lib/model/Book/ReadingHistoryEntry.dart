import 'package:cloud_firestore/cloud_firestore.dart';

class ReadingHistoryEntry {
  final String id;
  final String bookId;
  final String bookTitle;
  final String? bookCoverUrl;
  final Timestamp readDate;
  final double progress;
  final int duration; // Reading duration in minutes

  ReadingHistoryEntry({
    required this.id,
    required this.bookId,
    required this.bookTitle,
    this.bookCoverUrl,
    required this.readDate,
    required this.progress,
    this.duration = 0, // Default to 0 minutes
  });

  // Create a ReadingHistoryEntry from a Firestore document
  factory ReadingHistoryEntry.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ReadingHistoryEntry(
      id: doc.id,
      bookId: data['bookId'] ?? '',
      bookTitle: data['bookTitle'] ?? 'Unknown Book',
      bookCoverUrl: data['bookCoverUrl'],
      readDate: data['readDate'] ?? Timestamp.now(),
      progress: (data['progress'] ?? 0.0).toDouble(),
      duration: data['duration'] ?? 0,
    );
  }

  // Convert a ReadingHistoryEntry to a Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'bookId': bookId,
      'bookTitle': bookTitle,
      'bookCoverUrl': bookCoverUrl,
      'readDate': readDate,
      'progress': progress,
      'duration': duration,
    };
  }
}
