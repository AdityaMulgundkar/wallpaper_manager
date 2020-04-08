package com.mulgundkar.wallpaper_manager;
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import com.mulgundkar.wallpaper_manager.WallpaperManagerPlugin;

public class EmbeddingV1Activity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    WallpaperManagerPlugin.registerWith(registrarFor("com.mulgundkar.wallpaper_manager.WallpaperManagerPlugin"));
  }

}