import 'dart:async';
import 'package:flutter/services.dart';

class WallpaperManager {
  static const MethodChannel _channel =
      const MethodChannel('wallpaper_manager');

  static const int HOME_SCREEN = 1;
  static const int LOCK_SCREEN = 2;

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> setWallpaperFromFile(String filePath, int wallpaperLocation) async {
    final int result = await _channel.invokeMethod('setWallpaperFromFile', {'filePath':filePath, 'wallpaperLocation':wallpaperLocation});
    return result>0?"Wallpaper set":"There was an error.";
  }

  static Future<String> setWallpaperFromAsset(String assetPath, int wallpaperLocation) async {
    final int result = await _channel.invokeMethod('setWallpaperFromAsset', {'assetPath':assetPath, 'wallpaperLocation':wallpaperLocation});
    return result>0?"Wallpaper set":"There was an error.";
  }
}
