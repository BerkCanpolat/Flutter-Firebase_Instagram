import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_instagram/widgets/feedCard.dart';

class FeedScreenDart extends StatefulWidget {
  const FeedScreenDart({super.key});

  @override
  State<FeedScreenDart> createState() => _FeedScreenDartState();
}

class _FeedScreenDartState extends State<FeedScreenDart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/ins.png",height: 32,),
        actions: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: Icon(Icons.mail,color: Colors.black,), onPressed: (){}),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
        .collection("Post")
        .orderBy("datePublished",descending: true)
        .snapshots(),
        builder: (context, AsyncSnapshot <QuerySnapshot<Map<String,dynamic>>> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => FeedCard(
              snap: snapshot.data!.docs[index].data(),
            ),
          );
        },
      ),
    );
  }
}