import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';

class AudioService {
  static late FlutterTts _tts;
  static late AudioPlayer _audioPlayer;
  static bool _isMuted = false;

  static Future<void> initialize() async {
    _tts = FlutterTts();
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.5); // Slower speech for children
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
    
    _audioPlayer = AudioPlayer();
  }

  static Future<void> speak(String text) async {
    if (_isMuted) return;
    await _tts.stop();
    await _tts.speak(text);
  }

  static Future<void> speakSlowly(String text) async {
    if (_isMuted) return;
    await _tts.stop();
    await _tts.setSpeechRate(0.4);
    await _tts.speak(text);
    await _tts.setSpeechRate(0.5); // Reset to default
  }

  static Future<void> playSound(String soundType) async {
    if (_isMuted) return;
    
    String assetPath;
    switch (soundType) {
      case 'correct':
        assetPath = 'assets/sounds/correct.mp3';
        break;
      case 'incorrect':
        assetPath = 'assets/sounds/incorrect.mp3';
        break;
      case 'success':
        assetPath = 'assets/sounds/success.mp3';
        break;
      case 'click':
        assetPath = 'assets/sounds/click.mp3';
        break;
      default:
        assetPath = 'assets/sounds/click.mp3';
    }
    
    try {
      await _audioPlayer.setAsset(assetPath);
      await _audioPlayer.play();
    } catch (e) {
      print('Error playing sound: $e');
    }
  }

  static void setMuted(bool muted) {
    _isMuted = muted;
  }

  static bool isMuted() {
    return _isMuted;
  }

  static void dispose() {
    _tts.stop();
    _audioPlayer.dispose();
  }
}

