import 'dart:async';
import 'package:talkhands/features/screens/signup/success_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../data/repositories/authentication_repository.dart';

/// VerifyEmailController manages the email verification process.
/// It sends a verification email, monitors the user's email verification status,
/// and redirects the user to the success screen upon successful verification.
class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  /// Called when the controller is initialized.
  /// - Sends the initial email verification.
  /// - Sets up a timer to periodically check for email verification status.
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  /// Sends a verification email to the currently authenticated user.
  /// Utilizes the `AuthenticationRepository` to perform the action.
  Future<void> sendEmailVerification() async {
    await AuthenticationRepository.instance.sendEmailVerification();
  }

  /// Sets up a periodic timer to automatically check the user's email verification status.
  /// - Reloads the user data from Firebase Authentication every second.
  /// - If the user's email is verified, cancels the timer and redirects to the `SuccessScreen`.
  void setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => const SuccessScreen());
      }
    });
  }

  /// Manually checks the user's email verification status.
  /// - If the user's email is verified, redirects to the `SuccessScreen`.
  Future<void> checkEmailVerification() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => const SuccessScreen());
    }
  }
}
