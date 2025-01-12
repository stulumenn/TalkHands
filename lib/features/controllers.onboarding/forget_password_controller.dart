import 'package:talkhands/data/repositories/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:talkhands/features/screens/signup/reset_password.dart';

/// ForgetPasswordController handles the functionality for resetting a user's password.
/// It communicates with the AuthenticationRepository to send password reset emails and manages the associated UI logic.
class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();
  final email = TextEditingController();

  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  /// Sends a password reset email to the provided email address.
  /// - Reads the email input from the `email` TextEditingController.
  /// - Navigates to the `ResetPasswordScreen` after successfully sending the email.
  Future<void> sendPasswordResetEmail() async {
    await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());
    Get.to(() => ResetPasswordScreen(email: email.text.trim()));
  }

  /// Resends a password reset email to a given email address.
  /// - [email]: The email address where the password reset email will be sent.
  Future<void> resendPasswordResetEmail(String email) async {
    await AuthenticationRepository.instance.sendPasswordResetEmail(email);
  }
}
