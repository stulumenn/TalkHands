import 'package:talkhands/features/controllers.onboarding/signup_controller.dart';
import 'package:talkhands/data/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Let's create your account", style: TTextTheme.lightTextTheme.headlineMedium,),
              const SizedBox(height: 32.0,),
              Form(child: Column(
                key: controller.signupFormKey,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.firstName,
                          expands: false,
                          decoration: const InputDecoration(labelText: "First Name", prefixIcon: Icon(Iconsax.user_copy),),
                        ),
                      ),
                      const SizedBox(width: 16.0,),
                      Expanded(
                        child: TextFormField(
                          controller: controller.lastName,
                          expands: false,
                          decoration: const InputDecoration(labelText: "Last Name", prefixIcon: Icon(Iconsax.user_copy),),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0,),
                  TextFormField(
                    controller: controller.username,
                    expands: false,
                    decoration: const InputDecoration(labelText: "Username", prefixIcon: Icon(Iconsax.user_edit_copy),),
                  ),
                  const SizedBox(height: 16.0,),
                  TextFormField(
                    controller: controller.email,
                    expands: false,
                    decoration: const InputDecoration(labelText: "E-mail", prefixIcon: Icon(Iconsax.direct_copy),),
                  ),
                  const SizedBox(height: 16.0,),
                  TextFormField(
                    controller: controller.phoneNumber,
                    expands: false,
                    decoration: const InputDecoration(labelText: "Phone number", prefixIcon: Icon(Iconsax.call_copy),),
                  ),
                  const SizedBox(height: 16.0,),
                  Obx(
                    () => TextFormField(
                      controller: controller.password,
                      obscureText: controller.hidePassword.value,
                      decoration: InputDecoration(labelText: "Password", prefixIcon: const Icon(Iconsax.password_check_copy), suffixIcon: IconButton(onPressed: () => controller.hidePassword.value = !controller.hidePassword.value, icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash_copy : Iconsax.eye_copy))),
                    ),
                  ),
                  const SizedBox(height: 32.0,),

                  Row(
                    children: [
                      SizedBox(width: 24, height: 24, child: Obx(() => Checkbox(value: controller.privacyPolicy.value, onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value))),
                      const SizedBox(width: 24.0,),
                      Text.rich(
                          TextSpan(children: [
                            TextSpan(text: "I agree to", style: TTextTheme.lightTextTheme.bodySmall),
                            TextSpan(text: " Privacy Policy ", style: TTextTheme.lightTextTheme.bodyMedium!.apply(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blue
                            )),
                            TextSpan(text: "and", style: TTextTheme.lightTextTheme.bodySmall),
                            TextSpan(text: " Terms of Use", style: TTextTheme.lightTextTheme.bodyMedium!.apply(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue
                            )),
                          ]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32.0,),
                  SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => controller.signup(), child: const Text("Create Account")),)
                ],
                ),
              ),
              const SizedBox(height: 32.0,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(child: Divider(color: Colors.black26,thickness: 1, indent: 60, endIndent: 5,)),
                  Text("or sign up with",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.black26)
                  ),
                  Flexible(child: Divider(color: Colors.black26,thickness: 1, indent: 5, endIndent: 60,)),
                ],
              ),
              const SizedBox(height: 32.0,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.black38), borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Iconsax.google_copy),
                    ),
                  ),
                  const SizedBox(width: 16.0,),
                  Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.black38), borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Iconsax.facebook_copy),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
