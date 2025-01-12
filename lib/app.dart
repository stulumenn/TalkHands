import 'package:talkhands/features/screens/onboarding/splash.dart';
import 'package:flutter/material.dart';
import 'package:talkhands/data/theme/theme.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App ({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false, // Disables the debug banner that appears in the top-right corner during development.
      title: 'talkhands', // The title of the app shown in the taskbar or app switcher.
      theme: TAppTheme.lightTheme, // Sets the theme for the app, which is defined in TAppTheme.
      home: const SplashScreen(), // Defines the initial screen of the app, which is the SplashScreen in this case.
    );
  }
}
