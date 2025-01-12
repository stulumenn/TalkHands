import 'package:talkhands/data/repositories/authentication_repository.dart';
import 'package:talkhands/data/repositories/user_repository.dart';
import 'package:talkhands/features/screens/login/login.dart';
import 'package:talkhands/features/screens/settings/re_authenticate_user_login_form.dart';
import 'personalization/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// LoginController manages the login process, user authentication, and account management.
/// It handles login with email/password or Google, re-authentication, and user record fetching.
class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userRepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();

    fetchUserRecord();
  }

  /// Fetches the current user's record from Firestore.
  Future<void> fetchUserRecord() async {
    final fetchedUser = await userRepository.fetchUserDetails();
    this.user(fetchedUser);
  }

  /// Deletes the user's account based on their authentication provider.
  /// If the provider is Google, re-authenticate via Google, then delete the account.
  /// If the provider is password-based, prompt re-authentication.
  void deleteUserAccount() async {
    final auth = AuthenticationRepository.instance;
    final provider = auth.authUser!.providerData.map((e) => e.providerId).first;

    if (provider.isNotEmpty) {
      if (provider == 'google.com') {
        await auth.signInWithGoogle();
        await auth.deleteAccount();
        Get.offAll(() => const LoginScreen());
      } else if (provider == 'password') {
        Get.to(() => const ReAuthLoginForm());
      }
    }
  }

  /// Re-authenticate the user with email and password, then delete their account.
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    await AuthenticationRepository.instance.reAuthenticateWithEmailAndPassword(
      verifyEmail.text.trim(),
      verifyPassword.text.trim(),
    );
    await AuthenticationRepository.instance.deleteAccount();
    Get.offAll(() => const LoginScreen());
  }

  /// Sign in the user with email and password, with optional "remember me" functionality.
  /// - If "remember me" is enabled, store the credentials in local storage.
  /// - After successful login, redirect the user to the appropriate screen.
  Future<void> emailAndPasswordSignIn() async {
    if (rememberMe.value) {
      localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
      localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
    }

    final userCredentials = await AuthenticationRepository.instance.loginWithEmailAndPassword(
      email.text.trim(),
      password.text.trim(),
    );

    AuthenticationRepository.instance.screenRedirect();
  }

  /// Sign in the user with Google authentication.
  Future<void> googleSignIn() async {
    final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();
    await saveUserRecord(userCredentials);
    AuthenticationRepository.instance.screenRedirect();
  }

  /// Saves the user record to Firestore after a successful sign-in.
  /// This function handles the creation of a `UserModel` object and stores it in Firestore.
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    if (userCredentials != null) {
      final nameParts = UserModel.nameParts(userCredentials.user!.displayName ?? '');
      final username = UserModel.generateUsername(userCredentials.user!.displayName ?? '');

      final user = UserModel(
        id: userCredentials.user!.uid,
        firstName: nameParts[0],
        lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : ' ',
        username: username,
        email: userCredentials.user!.email ?? ' ',
        phoneNumber: userCredentials.user!.phoneNumber ?? ' ',
        profilePicture: userCredentials.user!.photoURL ?? ' ',
      );

      await userRepository.saveUserRecord(user);
    }
  }
}
