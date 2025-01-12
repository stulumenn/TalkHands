import 'package:talkhands/data/repositories/user_repository.dart';
import 'package:talkhands/features/controllers.onboarding/login_controller.dart';
import 'package:talkhands/features/screens/settings/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// UpdateNameController manages the functionality for updating a user's first and last names.
/// It interacts with the `UserRepository` to update the user's name in the database
/// and ensures the changes are reflected in the local state.
class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = Get.put(LoginController());
  final userRepository = Get.put(UserRepository());

  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  /// Initializes the controller and sets the input fields with the current user's names.
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  /// Loads the current user's first and last names into the text controllers.
  /// This ensures the input fields are pre-filled with the user's existing data.
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  /// Updates the user's first and last names in the database.
  /// - Sends the updated names to the `UserRepository` to update the user's record in Firestore.
  /// - Updates the local state with the new names.
  /// - Redirects the user to the `ProfilePage` upon successful update.
  Future<void> updateUserName() async {
    Map<String, dynamic> name = {
      'FirstName': firstName.text.trim(),
      'LastName': lastName.text.trim()
    };

    await userRepository.updateSingleField(name);

    userController.user.value.firstName = firstName.text.trim();
    userController.user.value.lastName = lastName.text.trim();

    Get.off(() => const ProfilePage());
  }
}
