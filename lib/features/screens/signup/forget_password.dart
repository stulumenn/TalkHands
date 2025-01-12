import 'package:talkhands/features/controllers.onboarding/forget_password_controller.dart';
import 'package:talkhands/data/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Forget Password", style: TTextTheme.lightTextTheme.headlineMedium,),
            const SizedBox(height: 24.0,),
            Text("Don't worry sometimes people can forget too, enter your email and we will send you a password reset link.", style: TTextTheme.lightTextTheme.labelMedium,),
            const SizedBox(height: 24.0,),

            Form(
              key: controller.forgetPasswordFormKey,
              child: TextFormField(
                controller: controller.email,
                decoration: const InputDecoration(labelText: "Email", prefixIcon: Icon(Iconsax.direct_right_copy)),
              ),
            ),
            const SizedBox(height: 24.0,),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () => controller.sendPasswordResetEmail(), child: const Text("Submit")),
            )
          ],
        ),
      ),
    );
  }
}
