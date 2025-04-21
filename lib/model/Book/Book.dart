import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String id;
  final String title;
  final String? subtitle;
  final List<String> authors;
  final String publisher;
  final String publishedDate;
  final String description;
  final String pageCount;
  final List<String> categories;
  final String averageRating;
  final int ratingsCount;
  final String maturityRating;
  final String language;
  final List<String> industryIdentifiers;
  final Map<String, String> imageLinks;
  final String previewLink;
  final String infoLink;
  final String canonicalVolumeLink;
  final Map<String, dynamic> accessInfo;
  final bool trending;
  final Timestamp? createdAt;

  Book({
    required this.id,
    required this.title,
    this.subtitle,
    required this.authors,
    required this.publisher,
    required this.publishedDate,
    required this.description,
    required this.pageCount,
    required this.categories,
    required this.averageRating,
    required this.ratingsCount,
    required this.maturityRating,
    required this.language,
    required this.industryIdentifiers,
    required this.imageLinks,
    required this.previewLink,
    required this.infoLink,
    required this.canonicalVolumeLink,
    required this.accessInfo,
    this.trending = false,
    this.createdAt,
  });

  factory Book.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Book(
      id: doc.id,
      title: data['title'] ?? 'No title available',
      subtitle: data['subtitle'],
      authors: List<String>.from(data['authors'] ?? []),
      publisher: data['publisher'] ?? 'Unknown publisher',
      publishedDate: data['publishedDate'] ?? 'Unknown date',
      description: data['description'] ?? 'No description available',
      pageCount: data['pageCount']?.toString() ?? '0',
      categories: List<String>.from(data['categories'] ?? []),
      averageRating: data['averageRating']?.toString() ?? '0.0',
      ratingsCount: data['ratingsCount'] ?? 0,
      maturityRating: data['maturityRating'] ?? 'Unknown',
      language: data['language'] ?? 'Unknown',
      industryIdentifiers: List<String>.from(data['industryIdentifiers'] ?? []),
      imageLinks: Map<String, String>.from(data['imageLinks'] ?? {}),
      previewLink: data['previewLink'] ?? '',
      infoLink: data['infoLink'] ?? '',
      canonicalVolumeLink: data['canonicalVolumeLink'] ?? '',
      accessInfo: data['accessInfo'] ?? {},
      trending: data['trending'] ?? false,
      createdAt: data['createdAt'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'subtitle': subtitle,
      'authors': authors,
      'publisher': publisher,
      'publishedDate': publishedDate,
      'description': description,
      'pageCount': pageCount,
      'categories': categories,
      'averageRating': averageRating,
      'ratingsCount': ratingsCount,
      'maturityRating': maturityRating,
      'language': language,
      'industryIdentifiers': industryIdentifiers,
      'imageLinks': imageLinks,
      'previewLink': previewLink,
      'infoLink': infoLink,
      'canonicalVolumeLink': canonicalVolumeLink,
      'accessInfo': accessInfo,
      'trending': trending,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }

  factory Book.fromGoogleBooksApi(Map<String, dynamic> data) {
    return Book(
      id: data['id'] ?? '',
      title: data['title'] ?? 'No title available',
      subtitle: data['subtitle'],
      authors: List<String>.from(data['authors'] ?? []),
      publisher: data['publisher'] ?? 'Unknown publisher',
      publishedDate: data['publishedDate'] ?? 'Unknown date',
      description: data['description'] ?? 'No description available',
      pageCount: data['pageCount']?.toString() ?? '0',
      categories: List<String>.from(data['categories'] ?? []),
      averageRating: data['averageRating']?.toString() ?? '0.0',
      ratingsCount: data['ratingsCount'] ?? 0,
      maturityRating: data['maturityRating'] ?? 'Unknown',
      language: data['language'] ?? 'Unknown',
      industryIdentifiers: List<String>.from(data['industryIdentifiers'] ?? []),
      imageLinks: Map<String, String>.from(data['imageLinks'] ?? {}),
      previewLink: data['previewLink'] ?? '',
      infoLink: data['infoLink'] ?? '',
      canonicalVolumeLink: data['canonicalVolumeLink'] ?? '',
      accessInfo: data['accessInfo'] ?? {},
      trending: false,
    );
  }
}