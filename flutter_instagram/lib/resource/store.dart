import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram/model/post.dart';
import 'package:flutter_instagram/resource/storage.dart';
import 'package:uuid/uuid.dart';

class StoreMethod{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> posted(
    String name,
    String description,
    String profImage,
    String uid,
    Uint8List file,
  ) async{
    String res = "Post Paylaşırken hata";
    try {
      String photoUrl = await StorageMethod().storageUser("Post", file, true);

      String postId = Uuid().v1();

      PostModel postModel = PostModel(
        name: name,
        description: description,
        profImage: profImage,
        uid: uid,
        postId: postId,
        postUrl: photoUrl,
        datePublished: DateTime.now(),
        like: [],
      );

      _firestore.collection("Post").doc(postId).set(postModel.toJson());

      res = "Başarılı";

    } catch (e) {
      res = e.toString();
    }
    return res;
  }




  Future<void> like(String uid, String postId, List like) async{
    try {
      if(like.contains(uid)){
        await _firestore.collection("Post").doc(postId).update({
          "like": FieldValue.arrayRemove([uid])
        });
      }else{
        await _firestore.collection("Post").doc(postId).update({
          "like": FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      e.toString();
    }
  }


  Future<void> comments(String uid, String postId, String name, String profilePic, String text) async{
    try {
      if(text.isNotEmpty){
        String commentId = Uuid().v1();
        await _firestore.collection("Post").doc(postId).collection("comments").doc(commentId).set({
          "name":name,
          "profilePic":profilePic,
          "uid":uid,
          "text":text,
          "datePublished":DateTime.now(),
          "commentId":commentId,
        });
      }
    } catch (e) {
      e.toString();
    }
  }


  Future<void> delete(String postId) async{
    try {
      await _firestore.collection("Post").doc(postId).delete();
    } catch (e) {
      
    }
  }

  Future<void> followers(
    String uid,
    String followId
  ) async{
    try {
      DocumentSnapshot snap = await _firestore.collection("users").doc(uid).get();

      List following = (snap.data()! as dynamic)["following"];

      if(following.contains(followId)){
        await _firestore.collection("users").doc(followId).update({
          "followers":FieldValue.arrayRemove([uid])
        });
        await _firestore.collection("users").doc(uid).update({
          "following":FieldValue.arrayRemove([followId])
        });
      }else{
        await _firestore.collection("users").doc(followId).update({
          "followers":FieldValue.arrayUnion([uid])
        });
        await _firestore.collection("users").doc(uid).update({
          "following":FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      e.toString();
    }
  }
}