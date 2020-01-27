import 'dart:async';
import 'package:flutter/services.dart';

class WallpaperManager {
  // Define channel
  static const MethodChannel _channel =
      const MethodChannel('wallpaper_manager');

  // Static code for Home Screen Wallpaper Choice
  static const int HOME_SCREEN = 1;
  // Static code for Lock Screen Wallpaper Choice
  static const int LOCK_SCREEN = 2;

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    // Function returns version number
    return version;
  }

  static Future<String> setWallpaperFromFile(
      String filePath, int wallpaperLocation) async {
    // Function takes input file's path & location choice
    final int result = await _channel.invokeMethod('setWallpaperFromFile',
        {'filePath': filePath, 'wallpaperLocation': wallpaperLocation});
    // Function returns the set String as result, use for debugging
    return result > 0 ? "Wallpaper set" : "There was an error.";
  }

  static Future<String> setWallpaperFromAsset(
      String assetPath, int wallpaperLocation) async {
    // Function takes input file's asset (Dart/Flutter; pre-indexed in pubspec.yaml) & location choice
    final int result = await _channel.invokeMethod('setWallpaperFromAsset',
        {'assetPath': assetPath, 'wallpaperLocation': wallpaperLocation});
    // Function returns the set String as result, use for debugging
    return result > 0 ? "Wallpaper set" : "There was an error.";
  }
}
