import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _wallpaperFile = 'Unknown';
  String _wallpaperFileWithCrop = 'Unknown';
  String _wallpaperAsset = 'Unknown';
  String _wallpaperAssetWithCrop = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await WallpaperManager.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> setWallpaperFromFile() async {
    setState(() {
      _wallpaperFile = "Loading";
    });
    String result;
    var file = await DefaultCacheManager().getSingleFile(
        'https://images.unsplash.com/photo-1542435503-956c469947f6');
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await WallpaperManager.setWallpaperFromFile(
          file.path, WallpaperManager.HOME_SCREEN);
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _wallpaperFile = result;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> setWallpaperFromFileWithCrop() async {
    setState(() {
      _wallpaperFileWithCrop = "Loading";
    });
    String result;
    var file = await DefaultCacheManager().getSingleFile(
        'https://images.unsplash.com/photo-1542435503-956c469947f6');
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await WallpaperManager.setWallpaperFromFileWithCrop(
          file.path, WallpaperManager.HOME_SCREEN, 0, 0, 800, 800);
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _wallpaperFileWithCrop = result;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> setWallpaperFromAsset() async {
    setState(() {
      _wallpaperAsset = "Loading";
    });
    String result;
    String assetPath = "assets/tmp1.jpg";
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await WallpaperManager.setWallpaperFromAsset(
          assetPath, WallpaperManager.HOME_SCREEN);
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _wallpaperAsset = result;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> setWallpaperFromAssetWithCrop() async {
    setState(() {
      _wallpaperAssetWithCrop = "Loading";
    });
    String result;
    String assetPath = "assets/tmp1.jpg";
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await WallpaperManager.setWallpaperFromAssetWithCrop(
          assetPath, WallpaperManager.HOME_SCREEN, 0, 0, 800, 800);
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _wallpaperAssetWithCrop = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Column(
            children: <Widget>[
              ElevatedButton(
                child: Text("Platform Version"),
                onPressed: initPlatformState,
              ),
              Center(
                child: Text('Running on: $_platformVersion\n'),
              ),
              ElevatedButton(
                child: Text("Set wallpaper from file"),
                onPressed: setWallpaperFromFile,
              ),
              Center(
                child: Text('Wallpaper status: $_wallpaperFile\n'),
              ),
              ElevatedButton(
                child: Text("Set wallpaper from file with crop"),
                onPressed: setWallpaperFromFileWithCrop,
              ),
              Center(
                child: Text('Wallpaper status: $_wallpaperFileWithCrop\n'),
              ),
              ElevatedButton(
                child: Text("Set wallpaper from asset"),
                onPressed: setWallpaperFromAsset,
              ),
              Center(
                child: Text('Wallpaper status: $_wallpaperAsset\n'),
              ),
              ElevatedButton(
                child: Text("Set wallpaper from asset with crop"),
                onPressed: setWallpaperFromAssetWithCrop,
              ),
              Center(
                child: Text('Wallpaper status: $_wallpaperAssetWithCrop\n'),
              ),
            ],
          )),
    );
  }
}
