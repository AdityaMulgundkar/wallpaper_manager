package com.mulgundkar.wallpaper_manager;

import android.annotation.SuppressLint;
import android.app.WallpaperManager;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.res.AssetFileDescriptor;
import android.content.res.AssetManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Build;
import android.os.Environment;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Array;

import androidx.annotation.NonNull;
import io.flutter.Log;
import io.flutter.app.FlutterActivity;
import io.flutter.app.FlutterApplication;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.PluginRegistry;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** WallpaperManagerPlugin */
public class WallpaperManagerPlugin implements FlutterPlugin, MethodCallHandler {
  private Context context;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    context = flutterPluginBinding.getApplicationContext();
    final MethodChannel channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "wallpaper_manager");
    channel.setMethodCallHandler(this);
  }

  public void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "wallpaper_manager");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch (call.method) {
      case "getPlatformVersion":
        result.success("Android " + Build.VERSION.RELEASE);
        break;
      case "setWallpaperFromFile":
        result.success(setWallpaperFromFile((String) call.argument("filePath"), (int) call.argument("wallpaperLocation")));
        break;
      case "setWallpaperFromAsset":
        result.success(setWallpaperFromAsset((String) call.argument("assetPath"), (int) call.argument("wallpaperLocation")));
        break;
      default:
        result.notImplemented();
        break;
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
  }

  @SuppressLint("MissingPermission")
  private int setWallpaperFromFile(String filePath, int wallpaperLocation){
    int result = -1;
    Bitmap bitmap = BitmapFactory.decodeFile(filePath);
    WallpaperManager wm = null;
    if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.ECLAIR) {
      wm = WallpaperManager.getInstance(context);
      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
        try {
          result = wm.setBitmap(bitmap, null, false, wallpaperLocation);
        } catch (IOException e) {
          e.printStackTrace();
        }
      }
    }
    return result;
  }

  @SuppressLint("MissingPermission")
  private int setWallpaperFromAsset(String assetPath, int wallpaperLocation) {
    InputStream fd = null;
    int result = -1;
    try {
      fd = context.getAssets().open("flutter_assets/" + assetPath);
      Bitmap bitmap = BitmapFactory.decodeStream(fd);
      WallpaperManager wm = null;
      if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.ECLAIR) {
        wm = WallpaperManager.getInstance(context);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
          try {
            result = wm.setBitmap(bitmap, null, false, wallpaperLocation);
          } catch (IOException e) {
            e.printStackTrace();
          }
        }
      }
    } catch (IOException e) {
      e.printStackTrace();
    }
    return result;
  }
}
