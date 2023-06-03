import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_instagram/resource/auth.dart';
import 'package:flutter_instagram/resource/store.dart';
import 'package:flutter_instagram/screens/login.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({super.key,required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  var userData = {};
  bool isLoading = false;
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userGet();
  }

  userGet() async{
    setState(() {
      isLoading = true;
    });
    try {
    var userSnap = await FirebaseFirestore.instance.collection("users").doc(widget.uid).get();

    var postSnap = await FirebaseFirestore.instance.collection("Post").where("uid",isEqualTo: widget.uid).get();

    postLen = postSnap.docs.length;
    followers = userSnap.data()!["followers"].length;
    following = userSnap.data()!["following"].length;
    isFollowing = userSnap.data()!["followers"].contains(FirebaseAuth.instance.currentUser!.uid);

    userData = userSnap.data()!;
    setState(() {});
    } catch (e) {
      
    };
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Center(child: CircularProgressIndicator(),) : Scaffold(
      appBar: AppBar(
        title: Text(userData["name"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(userData["photoUrl"]),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildColumn(postLen, "post"),
                              buildColumn(followers, "follower"),
                              buildColumn(following, "following"),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FirebaseAuth.instance.currentUser!.uid == widget.uid ? SizedBox(
                                  width: 230,
                                  height: 25,
                                  child: ElevatedButton(
                                    onPressed: () async{
                                      await AuthMethod().signOut();
                                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
                                    }, 
                                    child: Text("Sign Out"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black
                                    ),
                                    ),
                                ) : isFollowing ? SizedBox(
                                  width: 230,
                                  height: 25,
                                  child: ElevatedButton(
                                    onPressed: () async{
                                      await StoreMethod().followers(FirebaseAuth.instance.currentUser!.uid, userData["uid"]);
                                      setState(() {
                                        isFollowing = false;
                                        followers--;
                                      });
                                    }, 
                                    child: Text("Unfollow"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black
                                    ),
                                    ),
                                ) : SizedBox(
                                  width: 230,
                                  height: 25,
                                  child: ElevatedButton(
                                    onPressed: () async{
                                      await StoreMethod().followers(FirebaseAuth.instance.currentUser!.uid, userData["uid"]);
                                      setState(() {
                                        isFollowing = true;
                                        followers++;
                                      });
                                    }, 
                                    child: Text("Follow"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black
                                    ),
                                    ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 15,left: 16,right: 16),
                child: Text(userData["name"]),
              ),
              Container(
                padding: EdgeInsets.only(top: 1,left: 16,right: 16),
                alignment: Alignment.centerLeft,
                child: Text(userData["bio"]),
              )

            ],
          ),
          Divider(thickness: 1),
          FutureBuilder(
            future: FirebaseFirestore.instance.collection("Post").where("uid", isEqualTo: widget.uid).get(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
              return GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 1.5,
                  childAspectRatio: 1
                  ),
                itemCount: (snapshot.data! as dynamic).docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot snap = (snapshot.data! as dynamic).docs[index];
                  return Image.network(
                    snap["postUrl"],fit: BoxFit.cover,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
  Column buildColumn(int num, String text){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Container(
            margin: EdgeInsets.only(top: 4),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[800]),
            )),
      ],
    );
  }
}