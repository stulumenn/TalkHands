import 'package:cloud_firestore/cloud_firestore.dart';

/// UserModel is a class that represents a user in the system.
/// It holds user information such as name, username, email, phone number, and profile picture.
class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

  /// Returns the full name of the user by combining the first and last name.
  String get fullName => '$firstName $lastName';

  /// Static method that splits a full name string into first and last name parts.
  /// Example: "John Doe" will return ["John", "Doe"].
  static List<String> nameParts(String fullName) => fullName.split(" ");

  /// Static method that generates a username from the user's full name.
  /// It uses the first and last name to create a camelCase username with a prefix.
  static String generateUsername(String fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = "$firstName$lastName";
    String usernameWithPrefix = "cwt_$camelCaseUsername"; // Prefix "cwt_" is added to the username
    return usernameWithPrefix;
  }

  /// Returns an empty UserModel instance with default values.
  static UserModel empty() => UserModel(
    id: '',
    firstName: '',
    lastName: '',
    username: '',
    email: '',
    phoneNumber: '',
    profilePicture: '',
  );

  /// Converts the UserModel instance to a map representation that can be saved to Firestore.
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'UserName': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
    };
  }

  /// Factory method that creates a UserModel instance from a Firestore document snapshot.
  /// It extracts user data from the Firestore document and returns a UserModel.
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        username: data['UserName'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
      );
    } else {
      throw Exception('Document data is null');
    }
  }
}
