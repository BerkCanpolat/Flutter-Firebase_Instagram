import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel{
  final String? name;
  final String? description;
  final String? postId;
  final String? profImage;
  final DateTime? datePublished;
  final String? uid;
  final String? postUrl;
  final like;

  PostModel({
    required this.name,
    required this.description,
    required this.postId,
    required this.profImage,
    required this.datePublished,
    required this.uid,
    required this.postUrl,
    required this.like,
  });

  Map<String,dynamic> toJson() => {
    "name":name,
    "description":description,
    "postId":postId,
    "profImage":profImage,
    "datePublished":datePublished,
    "uid":uid,
    "postUrl":postUrl,
    "like":like,
  };

  static PostModel fromSnap(DocumentSnapshot documentSnapshot){
    var snap = documentSnapshot.data() as Map<String,dynamic>?;

    return PostModel(
      name: snap?["name"],
      description: snap?["description"],
      postId: snap?["postId"],
      profImage: snap?["profImage"],
      datePublished: snap?["datePublished"],
      uid: snap?["uid"],
      postUrl: snap?["postUrl"],
      like: snap?["like"],
    );
  }
}