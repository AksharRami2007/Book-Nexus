import 'dart:async';
import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/model/ApiService/BookApiService.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class AudioplayercontrollerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Audioplayercontroller());
  }
}

class Audioplayercontroller extends BaseController {
  // Audio player
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Audio state
  RxDouble slider = 0.0.obs;
  RxBool isPlaying = false.obs;
  RxDouble duration = 0.0.obs;
  RxDouble position = 0.0.obs;
  RxDouble playbackSpeed = 1.0.obs;

  // Status message for UI feedback
  RxString statusMessage = 'Loading audio...'.obs;
  RxBool isAudioAvailable = false.obs;

  // Book data
  RxString bookTitle = 'Audio Book'.obs;
  RxString authors = 'Unknown Author'.obs;
  RxString coverImage = ''.obs;
  RxMap<String, dynamic> bookDetails = <String, dynamic>{}.obs;

  // API service
  final BookApiService _bookApiService = BookApiService();

  // Timer for updating position
  Timer? _positionTimer;

  @override
  void onInit() {
    super.onInit();

    // Get book data from arguments
    if (Get.arguments != null) {
      if (Get.arguments['bookTitle'] != null) {
        bookTitle.value = Get.arguments['bookTitle'];
      }

      if (Get.arguments['authors'] != null) {
        authors.value = Get.arguments['authors'];
      }

      if (Get.arguments['coverImage'] != null) {
        coverImage.value = Get.arguments['coverImage'];
      }

      if (Get.arguments['bookDetails'] != null) {
        bookDetails.value = Get.arguments['bookDetails'];
      }
    }

    // Initialize audio player
    initAudioPlayer();
  }

  Future<void> initAudioPlayer() async {
    try {
      statusMessage.value = 'Searching for audiobook...';

      // Try to find audio URL from free APIs based on book title
      final audioUrl = await findAudioUrl(bookTitle.value);

      if (audioUrl != null) {
        print('Found audio URL: $audioUrl');

        // Process the URL to ensure it's playable
        final processedUrl = await _processAudioUrl(audioUrl);
        print('Processed audio URL: $processedUrl');

        try {
          // Set up error handling for the audio player
          _audioPlayer.playbackEventStream.listen((event) {
            // Handle playback events
          }, onError: (Object e, StackTrace st) {
            print('Audio player error: $e');
            print('Stack trace: $st');
            statusMessage.value =
                'Error during playback. Trying alternative source...';
            _handlePlaybackError();
          });

          // Set the audio source with a timeout
          statusMessage.value = 'Loading audio...';
          await _audioPlayer.setUrl(processedUrl).timeout(Duration(seconds: 15),
              onTimeout: () {
            throw TimeoutException('Audio loading timed out');
          });

          isAudioAvailable.value = true;
          statusMessage.value = 'Audio loaded successfully';

          // Get the duration
          _audioPlayer.durationStream.listen((d) {
            if (d != null) {
              duration.value = d.inMilliseconds.toDouble();
            }
          });

          // Start a timer to update the position
          _positionTimer =
              Timer.periodic(Duration(milliseconds: 200), (timer) async {
            final position = await _audioPlayer.position;
            if (position != null) {
              this.position.value = position.inMilliseconds.toDouble();
              if (duration.value > 0) {
                slider.value =
                    (position.inMilliseconds / duration.value.toInt()) * 100;
              }
            }
          });

          // Listen to playback state changes and errors
          _audioPlayer.playerStateStream.listen((state) {
            isPlaying.value = state.playing;

            // Handle processing state
            if (state.processingState == ProcessingState.completed) {
              // Audio playback completed
              isPlaying.value = false;
            }

            // Log the processing state for debugging
            print('Audio processing state: ${state.processingState}');
          }, onError: (error) {
            print('Player state stream error: $error');
            _handlePlaybackError();
          });

          // Add a separate error listener
          _audioPlayer.processingStateStream.listen((state) {
            if (state == ProcessingState.idle && duration.value > 0) {
              // If we suddenly go back to idle after having a duration,
              // it might indicate an error
              print(
                  'Possible error: Processing state went to idle unexpectedly');
              _handlePlaybackError();
            }
          });

          // Try to play the audio
          await _audioPlayer.play();
        } catch (playbackError) {
          print('Error setting up audio playback: $playbackError');
          throw playbackError; // Rethrow to be caught by the outer try-catch
        }
      } else {
        // If no audio is found, use a fallback audio
        statusMessage.value = 'No audiobook found. Using sample audio instead.';
        _useFallbackAudio();
      }
    } catch (e) {
      print('Error initializing audio player: $e');
      statusMessage.value = 'Error loading audio: $e';
      // Use fallback audio in case of error
      _useFallbackAudio();
    }
  }

  // Process the audio URL to ensure it's in a playable format
  Future<String> _processAudioUrl(String url) async {
    try {
      // Check if the URL is a direct audio file or needs processing
      if (url.toLowerCase().endsWith('.mp3') ||
          url.toLowerCase().endsWith('.m4a') ||
          url.toLowerCase().endsWith('.wav')) {
        // Direct audio file, return as is
        return url;
      }

      // Check if it's an Internet Archive URL that might need processing
      if (url.contains('archive.org/download')) {
        // If it's a zip file, we might need to extract the first audio file
        if (url.toLowerCase().endsWith('.zip')) {
          // Try to construct a direct MP3 URL
          final baseUrl = url.substring(0, url.lastIndexOf('/'));
          final identifier = baseUrl.substring(baseUrl.lastIndexOf('/') + 1);

          // Try a few common patterns for Internet Archive audio files
          return '$baseUrl/${identifier}_64kb.mp3';
        }
      }

      // If we can't process it, return the original URL
      return url;
    } catch (e) {
      print('Error processing audio URL: $e');
      return url; // Return original URL if processing fails
    }
  }

  // Handle playback errors by trying fallback audio
  void _handlePlaybackError() {
    try {
      _useFallbackAudio();
    } catch (e) {
      print('Error handling playback error: $e');
      statusMessage.value = 'Could not load any audio.';
    }
  }

  // Use a reliable fallback audio source
  Future<void> _useFallbackAudio() async {
    try {
      // Reset the audio player first
      await _audioPlayer.stop();

      // Try a few different reliable audio sources in case one fails
      List<String> fallbackUrls = [
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
        'https://ia800805.us.archive.org/27/items/aliceinwonderland_1102_librivox/aliceinwonderland_01_carroll_64kb.mp3',
        'https://ia800805.us.archive.org/29/items/pride_and_prejudice_librivox/prideandprejudice_01-03_austen_64kb.mp3'
      ];

      bool audioLoaded = false;
      String errorMessage = '';

      // Try each fallback URL until one works
      for (String url in fallbackUrls) {
        try {
          print('Trying fallback audio URL: $url');
          statusMessage.value = 'Loading alternative audio...';

          await _audioPlayer.setUrl(url).timeout(Duration(seconds: 10));
          audioLoaded = true;
          isAudioAvailable.value = true;

          // Set up the same listeners as the main audio
          _audioPlayer.durationStream.listen((d) {
            if (d != null) {
              duration.value = d.inMilliseconds.toDouble();
            }
          });

          _positionTimer?.cancel(); // Cancel existing timer if any
          _positionTimer =
              Timer.periodic(Duration(milliseconds: 200), (timer) async {
            final position = await _audioPlayer.position;
            if (position != null) {
              this.position.value = position.inMilliseconds.toDouble();
              if (duration.value > 0) {
                slider.value =
                    (position.inMilliseconds / duration.value.toInt()) * 100;
              }
            }
          });

          _audioPlayer.playerStateStream.listen((state) {
            isPlaying.value = state.playing;
          }, onError: (e) {
            print('Fallback player state error: $e');
          });

          // Try to play the fallback audio
          await _audioPlayer.play();
          statusMessage.value = 'Playing sample audio';
          break; // Exit the loop if successful
        } catch (e) {
          print('Error with fallback URL $url: $e');
          errorMessage = e.toString();
          continue; // Try the next URL
        }
      }

      if (!audioLoaded) {
        throw Exception('All fallback URLs failed. Last error: $errorMessage');
      }
    } catch (e) {
      print('Error loading all fallback audio sources: $e');
      statusMessage.value = 'Could not load any audio.';
    }
  }

  Future<String?> findAudioUrl(String title) async {
    try {
      // Try to find audio from Internet Archive (primary source)
      final archiveUrl = await searchInternetArchive(title);
      if (archiveUrl != null) {
        return archiveUrl;
      }

      // Try to find audio from Librivox (secondary source)
      final librivoxUrl = await searchLibrivox(title);
      if (librivoxUrl != null) {
        return librivoxUrl;
      }

      // Try to find audio from Google Books API
      final googleBooksUrl = await searchGoogleBooks(title);
      if (googleBooksUrl != null) {
        return googleBooksUrl;
      }

      // No audio found from any source
      return null;
    } catch (e) {
      print('Error finding audio URL: $e');
      return null;
    }
  }

  Future<String?> searchLibrivox(String title) async {
    try {
      // Use the BookApiService to search for audiobooks in LibriVox
      final audioUrl = await _bookApiService.getLibrivoxAudioUrl(title);

      if (audioUrl != null) {
        print('Found LibriVox audio URL for "$title": $audioUrl');
        return audioUrl;
      }

      print('No LibriVox audiobook found for "$title"');

      // Fallback for certain popular titles if API fails
      if (title.toLowerCase().contains('pride and prejudice')) {
        return 'https://ia800805.us.archive.org/29/items/pride_and_prejudice_librivox/prideandprejudice_01-03_austen_64kb.mp3';
      } else if (title
          .toLowerCase()
          .contains('adventures of sherlock holmes')) {
        return 'https://ia800805.us.archive.org/27/items/adventures_holmes_rg_librivox/adventuresofsherlockholmes_01_doyle_64kb.mp3';
      } else if (title.toLowerCase().contains('alice')) {
        return 'https://ia800805.us.archive.org/27/items/aliceinwonderland_1102_librivox/aliceinwonderland_01_carroll_64kb.mp3';
      }

      // No match found
      return null;
    } catch (e) {
      print('Error searching Librivox: $e');

      // Fallback in case of error
      if (title.toLowerCase().contains('pride and prejudice')) {
        return 'https://ia800805.us.archive.org/29/items/pride_and_prejudice_librivox/prideandprejudice_01-03_austen_64kb.mp3';
      }

      return null;
    }
  }

  Future<String?> searchInternetArchive(String title) async {
    try {
      // Use the BookApiService to search for audiobooks in Internet Archive
      final audioUrl = await _bookApiService.getArchiveAudioUrl(title);

      if (audioUrl != null) {
        print('Found Internet Archive audio URL for "$title": $audioUrl');
        return audioUrl;
      }

      print('No Internet Archive audiobook found for "$title"');

      // Fallback for certain popular titles if API fails
      if (title.toLowerCase().contains('dracula')) {
        return 'https://ia800805.us.archive.org/24/items/dracula_librivox/dracula_01_stoker_64kb.mp3';
      } else if (title.toLowerCase().contains('frankenstein')) {
        return 'https://ia800805.us.archive.org/30/items/frankenstein_or_the_modern_prometheus_1312_librivox/frankenstein_01_shelley_64kb.mp3';
      } else if (title.toLowerCase().contains('pride and prejudice')) {
        return 'https://ia800805.us.archive.org/29/items/pride_and_prejudice_librivox/prideandprejudice_01-03_austen_64kb.mp3';
      } else if (title
          .toLowerCase()
          .contains('adventures of sherlock holmes')) {
        return 'https://ia800805.us.archive.org/27/items/adventures_holmes_rg_librivox/adventuresofsherlockholmes_01_doyle_64kb.mp3';
      } else if (title.toLowerCase().contains('alice')) {
        return 'https://ia800805.us.archive.org/27/items/aliceinwonderland_1102_librivox/aliceinwonderland_01_carroll_64kb.mp3';
      }

      // No match found
      return null;
    } catch (e) {
      print('Error searching Internet Archive: $e');

      // Fallback in case of error
      if (title.toLowerCase().contains('dracula')) {
        return 'https://ia800805.us.archive.org/24/items/dracula_librivox/dracula_01_stoker_64kb.mp3';
      }

      return null;
    }
  }

  Future<String?> searchGoogleBooks(String title) async {
    try {
      // For demonstration purposes, we'll return a sample URL
      // In a real app, you would use the Google Books API to get audio content

      // Simulate API call delay
      await Future.delayed(Duration(seconds: 1));

      // For demonstration, we'll always return null from Google Books API
      // as it doesn't directly provide audiobook content without authentication
      return null;
    } catch (e) {
      print('Error searching Google Books: $e');
      return null;
    }
  }

  void togglePlayPause() {
    if (isPlaying.value) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
    isPlaying.value = !isPlaying.value;
  }

  void skipForward() {
    final newPosition = position.value + 10000; // Skip 10 seconds
    if (newPosition < duration.value) {
      _audioPlayer.seek(Duration(milliseconds: newPosition.toInt()));
    } else {
      _audioPlayer.seek(Duration(milliseconds: duration.value.toInt()));
    }
  }

  void skipBackward() {
    final newPosition = position.value - 10000; // Skip back 10 seconds
    if (newPosition > 0) {
      _audioPlayer.seek(Duration(milliseconds: newPosition.toInt()));
    } else {
      _audioPlayer.seek(Duration.zero);
    }
  }

  void changeSpeed() {
    // Cycle through speeds: 1.0 -> 1.5 -> 2.0 -> 0.5 -> 1.0
    if (playbackSpeed.value == 1.0) {
      playbackSpeed.value = 1.5;
    } else if (playbackSpeed.value == 1.5) {
      playbackSpeed.value = 2.0;
    } else if (playbackSpeed.value == 2.0) {
      playbackSpeed.value = 0.5;
    } else {
      playbackSpeed.value = 1.0;
    }

    _audioPlayer.setSpeed(playbackSpeed.value);
  }

  void onchange(double newValue) {
    slider.value = newValue;

    // Convert slider value (0-100) to position in milliseconds
    final newPosition = (newValue / 100) * duration.value;
    _audioPlayer.seek(Duration(milliseconds: newPosition.toInt()));
  }

  @override
  void onClose() {
    _positionTimer?.cancel();
    _audioPlayer.dispose();
    super.onClose();
  }
}
