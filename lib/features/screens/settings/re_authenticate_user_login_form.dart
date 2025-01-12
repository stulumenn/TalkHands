import 'package:talkhands/features/controllers.onboarding/login_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = LoginController.instance;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: controller.reAuthFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: controller.verifyEmail,
                  decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct_right_copy), labelText: "Email"),
                ),
                const SizedBox(height: 16.0),

                Obx(
                    () => TextFormField(
                      obscureText: controller.hidePassword.value,
                      controller: controller.verifyPassword,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: const Icon(Iconsax.password_check_copy),
                        suffixIcon: IconButton(onPressed: () => controller.hidePassword.value = !controller.hidePassword.value , icon: const Icon(Iconsax.eye_slash_copy))
                      ),
                    )
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () => controller.reAuthenticateEmailAndPasswordUser(), child: const Text("Verify")),
                )
              ],
            ),
          ),
        ),
      ),
    );

  }
}
