import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';

@JsonSerializable()
class UserData {
  String uid;
  final String name;
  final String email;
  final DateTime createdAt;

  @JsonKey(
      fromJson: _documentReferenceFromJson, toJson: _documentReferenceToJson)
  final DocumentReference rolReference;

  UserData(this.uid, this.name, this.email, this.createdAt, this.rolReference);

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      json['uid'] as String,
      json['name'] as String,
      json['email'] as String,
      (json['createdAt'] as Timestamp)
          .toDate(), // Convert Timestamp to DateTime
      json['rol'] as DocumentReference,
    )..uid = json['uid'] as String;
  }

  Map<String, dynamic> toJson() => _$UserDataToJson(this);

  // Firebase CRUD operations
  static CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> createUserData() async {
    await usersCollection.add(toJson());
  }

  static Future<UserData?> getUserDataById(String userId) async {
    try {
      QuerySnapshot querySnapshot =
          await usersCollection.where('uid', isEqualTo: userId).get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot document = querySnapshot.docs.first;
        return UserData.fromJson(document.data() as Map<String, dynamic>)
          ..uid = document.id;
      } else {
        return null;
      }
    } catch (e) {
      // Handle any potential errors (e.g., network issues, etc.)
      print('Error getting user data: $e');
      return null;
    }
  }

  // Custom converter for DocumentReference
  static DocumentReference _documentReferenceFromJson(dynamic reference) {
    return FirebaseFirestore.instance.doc(reference);
  }

  static dynamic _documentReferenceToJson(DocumentReference reference) {
    return reference.path;
  }

  // Retrieve the current user's information
  static Future<UserData?> getCurrentUserData() async {
    UserData? user;
    User? userCredential = FirebaseAuth.instance.currentUser;

    if (userCredential != null) {
      String userId = userCredential.uid; // Use uid directly
      user = await getUserDataById(userId);
    }

    return user;
  }
}


// flutter pub run build_runner build --delete-conflicting-outputs
