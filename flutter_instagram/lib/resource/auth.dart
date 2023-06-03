import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_instagram/model/user.dart' as model;
import 'package:flutter_instagram/resource/storage.dart';

class AuthMethod{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<model.UserModel> userDetails() async{
    User user = _auth.currentUser!;

    DocumentSnapshot documentSnapshot = await _firestore.collection("users").doc(user.uid).get();

    return model.UserModel.fromSnap(documentSnapshot);
  }

  Future<String> signUp({
    required String name,
    required String email,
    required String password,
    required String bio,
    required Uint8List file,
  }) async{
    String res = "Kaydolurken bir hata oluştu";
    try {
      if(name.isNotEmpty || email.isNotEmpty || password.isNotEmpty || bio.isNotEmpty){
        UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);


        String photoUrl = await StorageMethod().storageUser("profilePicture", file, false);

        model.UserModel userModel = model.UserModel(
          name: name,
          email: email,
          password: password,
          bio: bio,
          photoUrl: photoUrl,
          uid: credential.user!.uid,
          followers: [],
          following: [],
        );

        await _firestore.collection("users").doc(credential.user!.uid).set(userModel.toJson());
      }
      res = "Kayıt olundu";
    } catch (e) {
      res = e.toString();
    }
    return res;
  } 

  Future<String> login(
    String email,
    String password,
  ) async{
    String res = "Gİriş yaparken hata";
    try {
      if(email.isNotEmpty || password.isNotEmpty){
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = "Giriş Başarılı";
      }else{
        res = "Lütfen tüm kutucukları doldurun";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }


  Future<void> signOut() async{
    await _auth.signOut();
  }
}