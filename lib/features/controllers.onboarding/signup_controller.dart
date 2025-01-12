import 'package:talkhands/data/repositories/authentication_repository.dart';
import 'package:talkhands/features/screens/signup/verify_email.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repositories/user_repository.dart';
import 'personalization/user_model.dart';

/// SignupController manages the user registration process.
/// It handles collecting user input, creating a new user in Firebase Authentication,
/// and saving user data in Firestore. After registration, it navigates to the email verification screen.
class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final hidePassword = true.obs;
  final privacyPolicy = true.obs;

  final email = TextEditingController();
  final lastName = TextEditingController();
  final firstName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  /// Signs up a new user using the provided email and password.
  /// - Creates a new user in Firebase Authentication.
  /// - Saves the user's details (first name, last name, username, etc.) in Firestore.
  /// - Navigates the user to the `VerifyEmailScreen` for email verification.
  void signup() async {
    final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(
      email.text.trim(),
      password.text.trim(),
    );

    final newUser = UserModel(
      id: userCredential.user!.uid,
      firstName: firstName.text.trim(),
      lastName: lastName.text.trim(),
      username: username.text.trim(),
      email: email.text.trim(),
      phoneNumber: phoneNumber.text.trim(),
      profilePicture: '',
    );

    final userRepository = Get.put(UserRepository());
    await userRepository.saveUserRecord(newUser);

    Get.to(() => VerifyEmailScreen(email: email.text.trim()));
  }
}
