package com.mulgundkar.wallpaper_manager;

import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.app.WallpaperManager;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.res.AssetFileDescriptor;
import android.content.res.AssetManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Rect;
import android.os.Build;
import android.os.Environment;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Array;

import androidx.annotation.NonNull;
import io.flutter.Log;
import io.flutter.app.FlutterApplication;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.loader.FlutterLoader;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.PluginRegistry;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * WallpaperManagerPlugin
 */
public class WallpaperManagerPlugin implements FlutterPlugin, MethodCallHandler {
    private static Context context;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        context = flutterPluginBinding.getApplicationContext();
        final MethodChannel channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "wallpaper_manager");
        channel.setMethodCallHandler(this);
    }

    public static void registerWith(Registrar pluginRegistrar) {
        context = pluginRegistrar.context();
        final MethodChannel channel = new MethodChannel(pluginRegistrar.messenger(), "wallpaper_manager");
        channel.setMethodCallHandler(new WallpaperManagerPlugin());
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
            case "setWallpaperFromFileWithCrop":
                result.success(setWallpaperFromFileWithCrop((String) call.argument("filePath"), (int) call.argument("wallpaperLocation"), (int) call.argument("left"), (int) call.argument("top"), (int) call.argument("right"), (int) call.argument("bottom")));
                break;
            case "setWallpaperFromAsset":
                result.success(setWallpaperFromAsset((String) call.argument("assetPath"), (int) call.argument("wallpaperLocation")));
                break;
            case "setWallpaperFromAssetWithCrop":
                result.success(setWallpaperFromAssetWithCrop((String) call.argument("assetPath"), (int) call.argument("wallpaperLocation"), (int) call.argument("left"), (int) call.argument("top"), (int) call.argument("right"), (int) call.argument("bottom")));
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        context = null;
    }

    @SuppressLint("MissingPermission")
    private int setWallpaperFromFile(String filePath, int wallpaperLocation) {
        int result = -1;
        Bitmap bitmap = BitmapFactory.decodeFile(filePath);
        WallpaperManager wm = WallpaperManager.getInstance(context);
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                result = wm.setBitmap(bitmap, null, false, wallpaperLocation);
            } else {
                wm.setBitmap(bitmap);
                result = 1;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result;
    }

    @SuppressLint("MissingPermission")
    private int setWallpaperFromFileWithCrop(String filePath, int wallpaperLocation, int left, int top, int right, int bottom) {
        int result = -1;
        Bitmap bitmap = BitmapFactory.decodeFile(filePath);
        WallpaperManager wm = WallpaperManager.getInstance(context);
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                result = wm.setBitmap(bitmap, new Rect(left, top, right, bottom), false, wallpaperLocation);
            } else {
                wm.setBitmap(bitmap);
                result = 1;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result;
    }

    @TargetApi(Build.VERSION_CODES.ECLAIR)
    @SuppressLint("MissingPermission")
    private int setWallpaperFromAsset(String assetPath, int wallpaperLocation) {
        int result = -1;
        try {
            WallpaperManager wm = WallpaperManager.getInstance(context);
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                InputStream inputStream = context.getAssets().open("flutter_assets/" + assetPath);
                Bitmap bitmap = BitmapFactory.decodeStream(inputStream);
                result = wm.setBitmap(bitmap, null, false, wallpaperLocation);
            } else {
                String assetLookupKey = FlutterLoader.getInstance().getLookupKeyForAsset(assetPath);
                AssetManager assetManager = context.getAssets();
                AssetFileDescriptor assetFileDescriptor = assetManager.openFd(assetLookupKey);
                InputStream inputStream = assetFileDescriptor.createInputStream();
                wm.setStream(inputStream);
                result = 1;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result;
    }

    @SuppressLint("MissingPermission")
    private int setWallpaperFromAssetWithCrop(String assetPath, int wallpaperLocation, int left, int top, int right, int bottom) {
        int result = -1;
        try {
            WallpaperManager wm = WallpaperManager.getInstance(context);
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                InputStream inputStream = context.getAssets().open("flutter_assets/" + assetPath);
                Bitmap bitmap = BitmapFactory.decodeStream(inputStream);
                result = wm.setBitmap(bitmap, new Rect(left, top, right, bottom), false, wallpaperLocation);
            } else {
                String assetLookupKey = FlutterLoader.getInstance().getLookupKeyForAsset(assetPath);
                AssetManager assetManager = context.getAssets();
                AssetFileDescriptor assetFileDescriptor = assetManager.openFd(assetLookupKey);
                InputStream inputStream = assetFileDescriptor.createInputStream();
                wm.setStream(inputStream);
                result = 1;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result;
    }
}