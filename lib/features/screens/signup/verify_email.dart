import 'package:talkhands/data/repositories/authentication_repository.dart';
import 'package:talkhands/features/controllers.onboarding/verify_email_controller.dart';
import 'package:talkhands/data/theme/custom_themes/text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});
  final String? email;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () => AuthenticationRepository.instance.logout(), icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Image(image: AssetImage("assets/images/aa8c323b10ccbcb38dc8c3aba776b90c.png")),
                const SizedBox(height: 32.0,),
                Text("Verify your email address!", style: TTextTheme.lightTextTheme.headlineMedium, textAlign: TextAlign.center,),
                const SizedBox(height: 16.0,),
                Text(email ?? '', style: TTextTheme.lightTextTheme.labelLarge, textAlign: TextAlign.center,),
                const SizedBox(height: 16.0,),
                Text("Congratulations Your Account Awaits: Verify Your Email to Start Communicating.", style: TTextTheme.lightTextTheme.labelMedium, textAlign: TextAlign.center,),
                const SizedBox(height: 32.0,),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => controller.checkEmailVerification(), child: const Text("Continue"))),
                const SizedBox(height: 16.0,),
                SizedBox(width: double.infinity, child: TextButton(onPressed: () => controller.sendEmailVerification(), child: const Text("Resend Email"))),
              ],
            ),
        ),
      ),
    );
  }
}
