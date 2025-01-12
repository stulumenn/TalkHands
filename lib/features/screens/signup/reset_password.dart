import 'package:talkhands/features/controllers.onboarding/forget_password_controller.dart';
import 'package:talkhands/features/screens/login/login.dart';
import 'package:talkhands/data/theme/custom_themes/text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [IconButton(onPressed: () => Get.back(), icon: const Icon(CupertinoIcons.clear))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 16.0,),
              Text(email, style: TTextTheme.lightTextTheme.bodyMedium, textAlign: TextAlign.center,),
              const SizedBox(height: 16.0,),
              Text("Password Reset Email Sent", style: TTextTheme.lightTextTheme.headlineMedium, textAlign: TextAlign.center,),
              const SizedBox(height: 16.0,),
              Text("Your Account Security is Our Priority! We've Sent You a Secure Link to Safely Change Your Password and Keep Your Account Protected", style: TTextTheme.lightTextTheme.labelMedium, textAlign: TextAlign.center,),
              const SizedBox(height: 24.0,),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () => Get.offAll(() => const LoginScreen()), child: const Text("Done")),
              ),
              const SizedBox(height: 16.0,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () => ForgetPasswordController.instance.resendPasswordResetEmail(email), child: const Text("Resend Email")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
