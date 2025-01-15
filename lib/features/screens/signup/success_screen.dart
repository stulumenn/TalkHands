import 'package:talkhands/data/repositories/authentication_repository.dart';
import 'package:talkhands/data/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(
              top: 56.0 * 2,
              bottom: 24.0 * 2,
              right: 24.0 * 2,
              left: 24.0 * 2,
            ),
            child: Column(
              children: [
                const Image(image: AssetImage("assets/images/13124789_5156366.jpg")),
                const SizedBox(height: 32.0,),
                Text("Your account successfully created!", style: TTextTheme.lightTextTheme.headlineMedium, textAlign: TextAlign.center,),
                const SizedBox(height: 16.0,),
                Text("Welcome to the world of languages", style: TTextTheme.lightTextTheme.labelMedium, textAlign: TextAlign.center,),
                const SizedBox(height: 32.0,),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => AuthenticationRepository.instance.screenRedirect(), child: const Text("Continue"))),
              ],
            ),
        ),
      ),
    );
  }
}
