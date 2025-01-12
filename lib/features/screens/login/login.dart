import 'package:talkhands/features/controllers.onboarding/login_controller.dart';
import 'package:talkhands/features/screens/signup/forget_password.dart';
import 'package:talkhands/features/screens/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the LoginController using GetX
    final controller = Get.put(LoginController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          // Padding around the entire screen content
          padding: const EdgeInsets.only(
            top: 56.0,  // Space from the top (for the status bar)
            bottom: 24.0,  // Space from the bottom
            right: 24.0,  // Right padding
            left: 24.0,  // Left padding
          ),
          child: Column(
            children: [
              // Logo and welcome text section
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    height: 150,
                    image: AssetImage("lib/data/assets/logos/applogo_black_transparent.png"),  // App logo
                  ),
                  Text("Welcome",
                    style: TextStyle(
                        fontSize: 28.0, fontWeight: FontWeight.w600, color: Colors.black
                    ),
                  ),
                  SizedBox(height: 12.0,),  // Spacer
                  Text("Login",
                    style: TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.normal, color: Colors.black
                    ),
                  ),
                  SizedBox(height: 12.0,),
                ],
              ),

              // Form section for login input fields
              Form(
                key: controller.loginFormKey,  // Assigning form key to validate the form
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),  // Padding for the form content
                  child: Column(
                    children: [
                      // Email input field
                      TextFormField(
                        controller: controller.email,  // Binding to the controller for email input
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.direct_right_copy),  // Icon before text
                            labelText: "Enter your E-mail"  // Label for email input
                        ),
                      ),
                      const SizedBox(height: 16.0,),  // Spacer between fields

                      // Password input field with toggleable visibility
                      Obx(
                            () => TextFormField(
                          controller: controller.password,
                          obscureText: controller.hidePassword.value,  // Toggle password visibility
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: const Icon(Iconsax.password_check_copy),  // Icon before text
                            suffixIcon: IconButton(
                              onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                              icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash_copy : Iconsax.eye_copy),
                            ),  // Toggle visibility when clicked
                          ),
                        ),
                      ),
                      const SizedBox(height: 12.0,),  // Spacer between fields

                      // Row containing 'Remember me' checkbox and 'Forgot Password' link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 'Remember me' checkbox
                          Row(
                            children: [
                              Obx(() => Checkbox(
                                value: controller.rememberMe.value,  // Track the checkbox state with Obx
                                onChanged: (value) => controller.rememberMe.value = !controller.rememberMe.value,  // Toggle state
                              )),
                              const Text("Remember me"),  // Text next to the checkbox
                            ],
                          ),

                          // Link to 'Forgot Password' screen
                          TextButton(
                            onPressed: () => Get.to(() => const ForgetPassword()),  // Navigate to forget password screen
                            child: const Text("Forgot Password?",),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32.0,),  // Spacer

                      // Sign In button that triggers the email/password login
                      SizedBox(width: double.infinity, child: ElevatedButton(
                          onPressed: () => controller.emailAndPasswordSignIn(),  // Call the login method from controller
                          child: const Text("Sign In")
                      )),
                      const SizedBox(height: 16.0,),  // Spacer

                      // Create Account button that navigates to the sign up screen
                      SizedBox(width: double.infinity, child: OutlinedButton(
                          onPressed: () => Get.to(() => const SignupScreen()),  // Navigate to sign up screen
                          child: const Text("Create Account")
                      )),
                      const SizedBox(height: 32.0,),  // Spacer
                    ],
                  ),
                ),
              ),

              // Divider with the text "or sign in with" in the middle
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(child: Divider(color: Colors.black26, thickness: 1, indent: 60, endIndent: 5,)),  // Divider to the left
                  Text("or sign in with",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.black26
                      )
                  ),
                  Flexible(child: Divider(color: Colors.black26, thickness: 1, indent: 5, endIndent: 60,)),  // Divider to the right
                ],
              ),
              const SizedBox(height: 32.0,),  // Spacer

              // Social login buttons (Google and Facebook)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Google sign in button
                  Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.black38), borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                      onPressed: () => controller.googleSignIn(),  // Call Google sign-in method from controller
                      icon: const Icon(Iconsax.google_copy),
                    ),
                  ),
                  const SizedBox(width: 16.0,),  // Spacer
                  // Facebook sign in button (currently inactive)
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
