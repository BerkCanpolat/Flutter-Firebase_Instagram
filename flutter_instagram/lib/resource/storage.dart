import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethod{
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> storageUser(String childName, Uint8List file, bool isPost) async{
    Reference ref = _storage.ref().child(childName).child(_auth.currentUser!.uid);

    if(isPost){
      String id = Uuid().v1();
      ref = ref.child(id);
    }

    UploadTask task = ref.putData(file);
    TaskSnapshot snapshot = await task;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl; 
  }
}