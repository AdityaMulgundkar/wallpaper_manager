[![Wallpaper Manager](https://i.imgur.com/pWgGxs5.png)](https://pub.dartlang.org/packages/wallpaper_manager)

A Flutter plugin for changing the Home Screen, Lock Screen (or both) Wallpaper(s) on Android devices.

[![Pub](https://img.shields.io/pub/v/wallpaper_manager.svg)](https://pub.dartlang.org/packages/wallpaper_manager)

## Usage

### Installation

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  ...
  wallpaper_manager: "^1.0.5"
```

In your library add the following import:

```dart
import 'package:wallpaper_manager/wallpaper_manager.dart';
```

### Example

#### Basic Usage
Since this is not a Widget, you have to create WallpaperManager constructors from inside an async function, which is a Future that returns a String output specifying success/failure.
```dart
String path = "/path/to/file/on/disk";
int location = WallpaperManager.HOME_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
final String result = await WallpaperManager.setWallpaperFromFile(path, location);
```

#### Basic Usage with error handling
You might want to wrap it in a try/catch since platform messages (plug-ins like these) may fail
```dart
String path = "/path/to/file/on/disk";
int location = WallpaperManager.HOME_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
String result;
try {
  result = await WallpaperManager.setWallpaperFromFile(path, location);
} on PlatformException {
  result = 'Failed to get wallpaper.';
}
```

#### Loading from a URL (with CacheManager, the image is saved to app files as well)
If you're loading a Wallpaper from a URL, you should save it to the disk first, then use the path of the saved image file.
Add flutter_cache_manager or any other dependency you'd like:
```yaml
dependencies:
  ...
  flutter_cache_manager: "^1.1.3"
```
And in dart code
```dart
String url = "";
int location = WallpaperManager.HOME_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
String result;
var file = await DefaultCacheManager().getSingleFile(url);
final String result = await WallpaperManager.setWallpaperFromFile(file.path, location);
```

#### Loading from a Flutter asset
If you're loading a Wallpaper from an asset, you need to make sure it is indexed in the pubspec.yaml file first
```yaml
dependencies:
  ...
  flutter:
    ...
    assets:
    - assets/tmp1.jpeg
```
And in dart code
```dart
String assetPath = "assets/tmp1.jpg";
int location = WallpaperManager.HOME_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
String result;
final String result = await WallpaperManager.setWallpaperFromAsset(assetPath, location);
```

## Getting started

### With Wallpaper Manager
See the `example` directory for a complete sample app using Wallpaper Manager.

### With Flutter
For help getting started with Flutter, view the online [documentation](https://flutter.io/).

## Notes
 * iOS does not support changing Wallpapers from third-party apps [\(Source\)](https://stackoverflow.com/questions/56112014/can-i-change-ios-screen-wallpaper-programmatically-in-swift-5-and-ios-12)
 * Xiaomi/MIUI does not support changing Lock Screen Wallpapers directly from the Android API [\(Source\)](https://in.c.mi.com/thread-1252992-1-0.html). You might want to look at creating a Lock Screen Launcher app instead.

## Todos
   - [ ] Write tests
   - [ ] Add rect values for optionally cropping the image
   - [ ] Add variable for re-using Wallpaper from phone's settings
   - [ ] Write more tests

## Changelog

Please see the [Changelog](https://github.com/AdityaMulgundkar/wallpaper_manager/blob/master/CHANGELOG.md) page to know what's recently changed.

## Contributions

Feel free to contribute to this project.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an [issue](https://github.com/AdityaMulgundkar/wallpaper_manager/issues).  
If you fixed a bug or implemented a feature, please send a [pull request](https://github.com/AdityaMulgundkar/wallpaper_manager/pulls).