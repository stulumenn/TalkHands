import 'package:talkhands/data/repositories/authentication_repository.dart';
import 'package:talkhands/features/controllers.onboarding/personalization/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

/// UserRepository is a service class for managing user data in Firebase Firestore.
/// It provides methods for saving, fetching, updating, and deleting user records.
class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  // Firebase Firestore instance for database operations
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Saves a new user record in the "Users" collection in Firestore.
  /// - [user]: The user data to be saved, passed as a `UserModel` instance.
  Future<void> saveUserRecord(UserModel user) async {
    await _db.collection("Users").doc(user.id).set(user.toJson());
  }

  /// Fetches user details from the "Users" collection based on the authenticated user's ID.
  /// - Returns a `UserModel` object with the user's details.
  /// - If the user document doesn't exist, returns an empty `UserModel`.
  Future<UserModel> fetchUserDetails() async {
    final documentSnapshot = await _db
        .collection("Users")
        .doc(AuthenticationRepository.instance.authUser?.uid)
        .get();

    if (documentSnapshot.exists) {
      return UserModel.fromSnapshot(documentSnapshot);
    } else {
      return UserModel.empty();
    }
  }

  /// Updates the details of an existing user record in Firestore.
  /// - [updatedUser]: The user data to update, passed as a `UserModel` instance.
  Future<void> updateUserDetails(UserModel updatedUser) async {
    await _db.collection("Users").doc(updatedUser.id).update(updatedUser.toJson());
  }

  /// Updates specific fields in a user document in Firestore.
  /// - [json]: A map containing the fields and their updated values.
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    await _db
        .collection("Users")
        .doc(AuthenticationRepository.instance.authUser?.uid)
        .update(json);
  }

  /// Removes a user record from the "Users" collection in Firestore.
  /// - [userId]: The ID of the user whose record should be deleted.
  Future<void> removeUserRecord(String userId) async {
    await _db.collection("Users").doc(userId).delete();
  }
}
