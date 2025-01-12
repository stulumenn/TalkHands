import 'user_repository.dart';
import 'package:talkhands/features/screens/home.dart';
import 'package:talkhands/features/screens/login/login.dart';
import 'package:talkhands/features/screens/onboarding/onboarding.dart';
import 'package:talkhands/features/screens/signup/verify_email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// AuthenticationRepository is a service class for managing user authentication
/// and session-related functionality using FirebaseAuth and GetX.
class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Local device storage for persisting simple values
  final deviceStorage = GetStorage();

  // Firebase Authentication instance
  final _auth = FirebaseAuth.instance;

  // Getter for the currently authenticated Firebase user
  User? get authUser => _auth.currentUser;

  /// Lifecycle method called when the controller is ready.
  /// Removes the splash screen and redirects the user to the appropriate screen.
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  /// Redirects the user to the appropriate screen based on their authentication status.
  /// - If the user is logged in and their email is verified, navigates to the `HomeScreen`.
  /// - If the user's email is not verified, navigates to the `VerifyEmailScreen`.
  /// - If the user is not logged in, checks if it's the first time opening the app and redirects accordingly.
  void screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const HomeScreen());
      } else {
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    } else {
      deviceStorage.writeIfNull('IsFirstTime', true);
      deviceStorage.read('IsFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(const OnBoardingScreen());
    }
  }

  /// Logs in a user with their email and password.
  /// - [email]: The user's email.
  /// - [password]: The user's password.
  /// - Returns a `UserCredential` object containing user authentication details.
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  /// Registers a new user with their email and password.
  /// - [email]: The user's email.
  /// - [password]: The user's password.
  /// - Returns a `UserCredential` object containing user authentication details.
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  /// Sends an email verification to the currently authenticated user.
  Future<void> sendEmailVerification() async {
    await _auth.currentUser?.sendEmailVerification();
  }

  /// Signs in a user using their Google account.
  /// - Returns a `UserCredential` object containing user authentication details.
  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;
    final credentials = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await _auth.signInWithCredential(credentials);
  }

  /// Logs out the current user from both Google and Firebase Authentication.
  /// - Redirects the user to the `LoginScreen`.
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => const LoginScreen());
  }

  /// Sends a password reset email to the specified email address.
  /// - [email]: The user's email address.
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  /// Deletes the currently authenticated user's account.
  /// - Removes the user record from the Firestore database via `UserRepository`.
  Future<void> deleteAccount() async {
    await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
    await _auth.currentUser?.delete();
  }

  /// Re-authenticates the current user with their email and password.
  /// - [email]: The user's email.
  /// - [password]: The user's password.
  Future<void> reAuthenticateWithEmailAndPassword(String email, String password) async {
    AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
    await _auth.currentUser!.reauthenticateWithCredential(credential);
  }
}
