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
  final AudioPlayer _audioPlayer = AudioPlayer();

  RxDouble slider = 0.0.obs;
  RxBool isPlaying = false.obs;
  RxDouble duration = 0.0.obs;
  RxDouble position = 0.0.obs;
  RxDouble playbackSpeed = 1.0.obs;

  RxString statusMessage = 'Loading audio...'.obs;
  RxBool isAudioAvailable = false.obs;

  RxString bookTitle = 'Audio Book'.obs;
  RxString authors = 'Unknown Author'.obs;
  RxString coverImage = ''.obs;
  RxMap<String, dynamic> bookDetails = <String, dynamic>{}.obs;

  final BookApiService _bookApiService = BookApiService();

  Timer? _positionTimer;

  @override
  void onInit() {
    super.onInit();

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

    initAudioPlayer();
  }

  Future<void> initAudioPlayer() async {
    try {
      statusMessage.value = 'Searching for audiobook...';

      final audioUrl = await findAudioUrl(bookTitle.value);

      if (audioUrl != null) {
        print('Found audio URL: $audioUrl');

        final processedUrl = await _processAudioUrl(audioUrl);
        print('Processed audio URL: $processedUrl');

        try {
          _audioPlayer.playbackEventStream.listen((event) {},
              onError: (Object e, StackTrace st) {
            print('Audio player error: $e');
            print('Stack trace: $st');
            statusMessage.value =
                'Error during playback. Trying alternative source...';
            _handlePlaybackError();
          });

          statusMessage.value = 'Loading audio...';
          await _audioPlayer.setUrl(processedUrl).timeout(Duration(seconds: 15),
              onTimeout: () {
            throw TimeoutException('Audio loading timed out');
          });

          isAudioAvailable.value = true;
          statusMessage.value = 'Audio loaded successfully';

          _audioPlayer.durationStream.listen((d) {
            if (d != null) {
              duration.value = d.inMilliseconds.toDouble();
            }
          });

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

            if (state.processingState == ProcessingState.completed) {
              isPlaying.value = false;
            }

            print('Audio processing state: ${state.processingState}');
          }, onError: (error) {
            print('Player state stream error: $error');
            _handlePlaybackError();
          });

          _audioPlayer.processingStateStream.listen((state) {
            if (state == ProcessingState.idle && duration.value > 0) {
              print(
                  'Possible error: Processing state went to idle unexpectedly');
              _handlePlaybackError();
            }
          });

          await _audioPlayer.play();
        } catch (playbackError) {
          print('Error setting up audio playback: $playbackError');
          throw playbackError; // Rethrow to be caught by the outer try-catch
        }
      } else {
        statusMessage.value = 'No audiobook found. Using sample audio instead.';
        _useFallbackAudio();
      }
    } catch (e) {
      print('Error initializing audio player: $e');
      statusMessage.value = 'Error loading audio: $e';
      _useFallbackAudio();
    }
  }

  Future<String> _processAudioUrl(String url) async {
    try {
      if (url.toLowerCase().endsWith('.mp3') ||
          url.toLowerCase().endsWith('.m4a') ||
          url.toLowerCase().endsWith('.wav')) {
        return url;
      }

      if (url.contains('archive.org/download')) {
        if (url.toLowerCase().endsWith('.zip')) {
          final baseUrl = url.substring(0, url.lastIndexOf('/'));
          final identifier = baseUrl.substring(baseUrl.lastIndexOf('/') + 1);

          return '$baseUrl/${identifier}_64kb.mp3';
        }
      }

      return url;
    } catch (e) {
      print('Error processing audio URL: $e');
      return url;
    }
  }

  void _handlePlaybackError() {
    try {
      _useFallbackAudio();
    } catch (e) {
      print('Error handling playback error: $e');
      statusMessage.value = 'Could not load any audio.';
    }
  }

  Future<void> _useFallbackAudio() async {
    try {
      await _audioPlayer.stop();

      List<String> fallbackUrls = [
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
        'https://ia800805.us.archive.org/27/items/aliceinwonderland_1102_librivox/aliceinwonderland_01_carroll_64kb.mp3',
        'https://ia800805.us.archive.org/29/items/pride_and_prejudice_librivox/prideandprejudice_01-03_austen_64kb.mp3'
      ];

      bool audioLoaded = false;
      String errorMessage = '';

      for (String url in fallbackUrls) {
        try {
          print('Trying fallback audio URL: $url');
          statusMessage.value = 'Loading alternative audio...';

          await _audioPlayer.setUrl(url).timeout(Duration(seconds: 10));
          audioLoaded = true;
          isAudioAvailable.value = true;

          _audioPlayer.durationStream.listen((d) {
            if (d != null) {
              duration.value = d.inMilliseconds.toDouble();
            }
          });

          _positionTimer?.cancel();
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

          await _audioPlayer.play();
          statusMessage.value = 'Playing sample audio';
          break;
        } catch (e) {
          print('Error with fallback URL $url: $e');
          errorMessage = e.toString();
          continue;
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

  // Current API source being used
  RxString currentApiSource =
      'archive'.obs; // 'archive', 'librivox', or 'google'

  Future<String?> findAudioUrl(String title) async {
    try {
      String? audioUrl;

      // Only search using the current API source
      if (currentApiSource.value == 'archive') {
        audioUrl = await searchInternetArchive(title);
      } else if (currentApiSource.value == 'librivox') {
        audioUrl = await searchLibrivox(title);
      } else if (currentApiSource.value == 'google') {
        audioUrl = await searchGoogleBooks(title);
      }

      return audioUrl;
    } catch (e) {
      print('Error finding audio URL: $e');
      return null;
    }
  }

  // Method to try a different API source
  Future<void> tryAlternativeSource() async {
    // Rotate through available API sources
    if (currentApiSource.value == 'archive') {
      currentApiSource.value = 'librivox';
    } else if (currentApiSource.value == 'librivox') {
      currentApiSource.value = 'google';
    } else {
      currentApiSource.value = 'archive';
    }

    statusMessage.value =
        'Searching ${currentApiSource.value} for audiobook...';

    // Reinitialize the audio player with the new source
    await initAudioPlayer();
  }

  Future<String?> searchLibrivox(String title) async {
    try {
      final audioUrl = await _bookApiService.getLibrivoxAudioUrl(title);

      if (audioUrl != null) {
        print('Found LibriVox audio URL for "$title": $audioUrl');
        return audioUrl;
      }

      print('No LibriVox audiobook found for "$title"');
      if (title.toLowerCase().contains('pride and prejudice')) {
        return 'https://ia800805.us.archive.org/29/items/pride_and_prejudice_librivox/prideandprejudice_01-03_austen_64kb.mp3';
      } else if (title
          .toLowerCase()
          .contains('adventures of sherlock holmes')) {
        return 'https://ia800805.us.archive.org/27/items/adventures_holmes_rg_librivox/adventuresofsherlockholmes_01_doyle_64kb.mp3';
      } else if (title.toLowerCase().contains('alice')) {
        return 'https://ia800805.us.archive.org/27/items/aliceinwonderland_1102_librivox/aliceinwonderland_01_carroll_64kb.mp3';
      }

      return null;
    } catch (e) {
      print('Error searching Librivox: $e');

      if (title.toLowerCase().contains('pride and prejudice')) {
        return 'https://ia800805.us.archive.org/29/items/pride_and_prejudice_librivox/prideandprejudice_01-03_austen_64kb.mp3';
      }

      return null;
    }
  }

  Future<String?> searchInternetArchive(String title) async {
    try {
      final audioUrl = await _bookApiService.getArchiveAudioUrl(title);

      if (audioUrl != null) {
        print('Found Internet Archive audio URL for "$title": $audioUrl');
        return audioUrl;
      }

      print('No Internet Archive audiobook found for "$title"');

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

      return null;
    } catch (e) {
      print('Error searching Internet Archive: $e');

      if (title.toLowerCase().contains('dracula')) {
        return 'https://ia800805.us.archive.org/24/items/dracula_librivox/dracula_01_stoker_64kb.mp3';
      }

      return null;
    }
  }

  Future<String?> searchGoogleBooks(String title) async {
    try {
      await Future.delayed(Duration(seconds: 1));

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
    final newPosition = position.value + 10000;
    if (newPosition < duration.value) {
      _audioPlayer.seek(Duration(milliseconds: newPosition.toInt()));
    } else {
      _audioPlayer.seek(Duration(milliseconds: duration.value.toInt()));
    }
  }

  void skipBackward() {
    final newPosition = position.value - 10000;
    if (newPosition > 0) {
      _audioPlayer.seek(Duration(milliseconds: newPosition.toInt()));
    } else {
      _audioPlayer.seek(Duration.zero);
    }
  }

  void changeSpeed() {
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
