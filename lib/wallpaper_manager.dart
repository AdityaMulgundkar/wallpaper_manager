import 'dart:async';
import 'package:flutter/services.dart';

/// WallpaperManager plugin begins here
class WallpaperManager {
  /// Define channel
  static const MethodChannel _channel =
      const MethodChannel('wallpaper_manager');

  /// Static code for Home Screen Wallpaper Choice
  static const int HOME_SCREEN = 1;

  /// Static code for Lock Screen Wallpaper Choice
  static const int LOCK_SCREEN = 2;

  /// Static code for both Home Screen and Lock Screen Wallpaper Choice
  static const int BOTH_SCREENS = 3;

  /// Function to check working/validity of method channels
  static Future<String> get platformVersion async {
    /// String to store the version number before returning. This is just to test working/validity.
    final String version = await _channel.invokeMethod('getPlatformVersion');

    /// Function returns version number
    return version;
  }

  /// Function takes input file's path & location choice
  static Future<String> setWallpaperFromFile(
      String filePath, int wallpaperLocation) async {
    /// Variable to store operation result
    final int result = await _channel.invokeMethod('setWallpaperFromFile',
        {'filePath': filePath, 'wallpaperLocation': wallpaperLocation});

    /// Function returns the set String as result, use for debugging
    return result > 0 ? "Wallpaper set" : "There was an error.";
  }

  /// Function takes input file's path & location choice
  static Future<String> setWallpaperFromFileWithCrop(String filePath,
      int wallpaperLocation, int left, int top, int right, int bottom) async {
    /// Variable to store operation result
    int result;
    if (left > right || top > bottom) {
      result = 0;
    } else {
      result = await _channel.invokeMethod('setWallpaperFromFileWithCrop', {
        'filePath': filePath,
        'wallpaperLocation': wallpaperLocation,
        'left': left,
        'top': top,
        'right': right,
        'bottom': bottom
      });
    }

    /// Function returns the set String as result, use for debugging
    return result > 0 ? "Wallpaper set" : "There was an error.";
  }

  /// Function takes input file's asset (Dart/Flutter; pre-indexed in pubspec.yaml) & location choice
  static Future<String> setWallpaperFromAsset(
      String assetPath, int wallpaperLocation) async {
    /// Variable to store operation result
    final int result = await _channel.invokeMethod('setWallpaperFromAsset',
        {'assetPath': assetPath, 'wallpaperLocation': wallpaperLocation});

    /// Function returns the set String as result, use for debugging
    return result > 0 ? "Wallpaper set" : "There was an error.";
  }

  /// Function takes input file's asset (Dart/Flutter; pre-indexed in pubspec.yaml) & location choice
  static Future<String> setWallpaperFromAssetWithCrop(String assetPath,
      int wallpaperLocation, int left, int top, int right, int bottom) async {
    /// Variable to store operation result
    int result;
    if (left > right || top > bottom || left < 0 || top < 0) {
      result = 0;
    } else {
      result = await _channel.invokeMethod('setWallpaperFromAssetWithCrop', {
        'assetPath': assetPath,
        'wallpaperLocation': wallpaperLocation,
        'left': left,
        'top': top,
        'right': right,
        'bottom': bottom
      });
    }

    /// Function returns the set String as result, use for debugging
    return result > 0 ? "Wallpaper set" : "There was an error.";
  }
}
