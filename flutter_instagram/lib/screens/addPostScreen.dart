import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_instagram/model/user.dart';
import 'package:flutter_instagram/provider/provider.dart';
import 'package:flutter_instagram/resource/store.dart';
import 'package:flutter_instagram/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _description = TextEditingController();
  bool isLoading = false;

  void userPost(
    String name,
    String profImage,
    String uid,
  ) async{
    setState(() {
      isLoading = true;
    });
    String res = await StoreMethod().posted(name, _description.text, profImage, uid, _file!);
    if(res == "Başarılı"){
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, "Post Paylaşıldı!");
      clear();
    }else{
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, res);
    }
  }

  _selectPost(BuildContext context) async{
    return showDialog(
      context: context, 
      builder: (context) {
        return SimpleDialog(
          title: Text("Bir Fotoğraf Seç"),
          children: [
            SimpleDialogOption(
              child: Text("Galeriden Seç"),
              onPressed: () async{
                Navigator.of(context).pop();
                Uint8List file = await selectPickImage(ImageSource.gallery);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              child: Text("Kameradan Çek"),
              onPressed: () async{
                Navigator.of(context).pop();
                Uint8List file = await selectPickImage(ImageSource.camera);
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              child: Text("İptal"),
              onPressed: () async{
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
      );
  }

  void clear(){
    setState(() {
      _file = null;
    });
  }


  @override
  Widget build(BuildContext context) {
    final UserModel? user = Provider.of<InsProvider>(context).getUser;
    return _file == null ? Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Birşeyler Paylaş",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
        Icon(Icons.expand_more_outlined),
        Icon(Icons.expand_more_outlined),
        Icon(Icons.expand_more_outlined),
        Center(child: CupertinoButton(child: Icon(Icons.image,size: 100,color: Colors.black,), onPressed: () => _selectPost(context)),),
      ],
    ) :
    Scaffold(
      appBar: AppBar(
        title: Text("Post",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
        centerTitle: false,
        leading: CupertinoButton(child: Icon(Icons.arrow_back_ios,color: Colors.black,), onPressed: clear),
        actions: [
          TextButton(onPressed: () => userPost(user!.name!, user.photoUrl!, user.uid!), child: Text("Paylaş"))
        ],
      ),
      body: Column(
        children: [
          isLoading ? Center(child: LinearProgressIndicator(),) : Padding(padding: EdgeInsets.only(top: 10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              user?.photoUrl == null ? CircleAvatar(
                maxRadius: 45,
                backgroundImage: NetworkImage("https://images.unsplash.com/photo-1685776133440-437ffc5c4154?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60"),
              ) :
              CircleAvatar(
                maxRadius: 45,
                backgroundImage: NetworkImage(user!.photoUrl!),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: SizedBox(
                  width: 130,
                  height: 90,
                  child: TextField(
                    controller: _description,
                    decoration: InputDecoration(
                      hintText: "Birşeyler yaz..",
                      border: InputBorder.none,
                    ),
                    maxLines: 8,
                  ),
                ),
              ),
              CircleAvatar(
                maxRadius: 45,
                backgroundImage: MemoryImage(_file!),
              ),
            ],
          ),
        ],
      ),
    );
  }
}