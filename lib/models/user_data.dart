import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String username;
  final String email;
  final String createdAt;
  final String updatedAt;

  UserData({
    required this.username,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserData.fromFirestore(Map<String, dynamic> data) {
    return UserData(
      username: data["username"],
      email: data["email"],
      createdAt: (data["createdAt"] as Timestamp).toDate().toString(),
      updatedAt: (data["updatedAt"] as Timestamp).toDate().toString(),
    );
  }
}
