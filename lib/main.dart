import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app.dart';
import 'data/repositories/authentication_repository.dart';
import 'firebase_options.dart';

void main() async {
  // 1. Initialize GetStorage, which is used for local storage and caching.
  await GetStorage.init();
  // 2. Initialize Firebase with platform-specific options from firebase_options.dart.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
    // 3. After Firebase is initialized, put AuthenticationRepository into GetX's dependency injection system.
        (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );
  // 4. Run the app using GetMaterialApp which initializes GetX's routing and state management.
  runApp(const App());
}
