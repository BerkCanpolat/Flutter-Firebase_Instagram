import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String? name;
  final String? email;
  final String? password;
  final String? bio;
  final String? photoUrl;
  final String? uid;
  final List? followers;
  final List? following;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.bio,
    required this.photoUrl,
    required this.uid,
    required this.followers,
    required this.following,
  });

  Map<String,dynamic> toJson() => {
    "name":name,
    "email":email,
    "password":password,
    "bio":bio,
    "photoUrl":photoUrl,
    "uid":uid,
    "followers":followers,
    "following":following,
  };

  static UserModel fromSnap(DocumentSnapshot documentSnapshot){
    var snap = documentSnapshot.data() as Map<String,dynamic>?;

    return UserModel(
      name: snap?["name"],
      email: snap?["email"],
      password: snap?["password"],
      bio: snap?["bio"],
      photoUrl: snap?["photoUrl"],
      uid: snap?["uid"],
      followers: snap?["followers"],
      following: snap?["following"],
    );
  }
}