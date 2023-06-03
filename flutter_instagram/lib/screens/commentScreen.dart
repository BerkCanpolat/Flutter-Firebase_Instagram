import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_instagram/model/user.dart';
import 'package:flutter_instagram/provider/provider.dart';
import 'package:flutter_instagram/resource/store.dart';
import 'package:flutter_instagram/widgets/commentCard.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatefulWidget {
  final snap;
  const CommentScreen({super.key, required this.snap});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _textoEdito = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final UserModel? user = Provider.of<InsProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Yorumlar",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
        .collection("Post")
        .doc(widget.snap["postId"])
        .collection("comments")
        .orderBy("datePublished",descending: true)
        .snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          return ListView.builder(
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) => CommentCard(
              snap: (snapshot.data! as dynamic).docs[index].data(),
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user!.photoUrl!),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  controller: _textoEdito,
                  decoration: InputDecoration(
                      hintText: "Birşeyler yaz..  ${user.name}",
                      border: InputBorder.none),
                ),
              ),
              CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Text("Paylaş"),
                  onPressed: () async {
                    await StoreMethod().comments(
                        user.uid!,
                        widget.snap["postId"],
                        user.name!,
                        user.photoUrl!,
                        _textoEdito.text
                        );
                        setState(() {
                          _textoEdito.text = "";
                        });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
