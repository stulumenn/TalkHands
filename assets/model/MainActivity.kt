package com.example.gesture_recognition

import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import com.google.mediapipe.framework.AppTextureFrame

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.gesture_recognition"

    override fun configureFlutterEngine() {
        super.configureFlutterEngine()
        MethodChannel(flutterEngine!!.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "startGestureRecognition") {
                startGestureRecognition()
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun startGestureRecognition() {
        // Gesture Recognition başlatma işlemi burada yapılacak
        // Burada Mediapipe SDK'ını kullanarak Gesture Recognition başlatabilirsiniz.

        try {
            // Örnek bir Gesture Recognition başlatma
            Log.d("GestureRecognition", "Gesture recognition started successfully")

            // Burada Mediapipe'ın Gesture Recognition fonksiyonlarını başlatın
            // Örnek: GestureRecognizer().startRecognition()

        } catch (e: Exception) {
            Log.e("GestureRecognition", "Error starting recognition: ${e.message}")
        }
    }
}
