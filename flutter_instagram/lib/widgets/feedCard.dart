import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_instagram/model/user.dart';
import 'package:flutter_instagram/provider/provider.dart';
import 'package:flutter_instagram/resource/store.dart';
import 'package:flutter_instagram/screens/commentScreen.dart';
import 'package:flutter_instagram/widgets/like.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FeedCard extends StatefulWidget {
  final snap;
  const FeedCard({super.key,required this.snap});

  @override
  State<FeedCard> createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {

  bool isAnimating = false;
  bool isLoading = false;
  int commentlen = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    commentLen();
  }

  commentLen() async{
    try {
    QuerySnapshot snap = await FirebaseFirestore.instance.collection("Post").doc(widget.snap["postId"]).collection("comments").get();

    commentlen = snap.docs.length;
    } catch (e) {
      e.toString();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final UserModel? user = Provider.of<InsProvider>(context).getUser;
    return user == null ? Center(child: CircularProgressIndicator(),) :  isLoading ? Center(child: CircularProgressIndicator(),) : Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.snap["profImage"]),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      widget.snap["name"],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: ListView(
                                shrinkWrap: true,
                                children: ["Sil"]
                                    .map((e) => InkWell(
                                          onTap: () async{
                                             StoreMethod().delete(widget.snap["postId"]);
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(12),
                                            child: Text(e),
                                          ),
                                        ))
                                    .toList()),
                          );
                        },
                      );
                    })
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap: () async{
              await StoreMethod().like(user.uid!, widget.snap["postId"], widget.snap["like"]);
              setState(() {
                isAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [ 
                SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.35,
                child: Image.network(widget.snap["postUrl"],
                  fit: BoxFit.cover,
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isAnimating ? 1 : 0,
                child: LikeAnimation(
                  child: Icon(Icons.favorite,size: 100,color: Colors.white,), 
                  isAnimating: isAnimating,
                  duration: Duration(milliseconds: 350),
                  onEnd: () {
                    setState(() {
                      isAnimating = false;
                    });
                  },
                  ),
              )
              ]
            ),
          ),
          Container(
            child: Row(
              children: [
                // widget.snap["like"] == null ? Center(child: CircularProgressIndicator(),) :
                // user == null ? Center(child: CircularProgressIndicator(),) :
                LikeAnimation(
                  isAnimating: widget.snap["like"].contains(user.uid),
                  smallLike: true,
                  child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: widget.snap["like"].contains(user.uid) ? Icon(Icons.favorite,color: Colors.red,) : Icon(Icons.favorite_border,color: Colors.black,),
                      onPressed: () async{
                        await StoreMethod().like(user.uid!, widget.snap["postId"], widget.snap["like"]);
                      }
                      ),
                ),
                CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Icon(
                      Icons.chat,
                      color: Colors.black,
                    ),
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CommentScreen(
                      snap: widget.snap,
                    )))
                    ),
                CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Icon(
                      Icons.send,
                      color: Colors.black,
                    ),
                    onPressed: () {}),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Icon(
                          Icons.bookmark_border,
                          color: Colors.black,
                        ),
                        onPressed: () {}),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${widget.snap["like"].length} likes"),
                SizedBox(height: 5,),
                Container(
                  width: double.infinity,
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: widget.snap["name"],style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(
                          text: "  ${widget.snap["description"]}"
                        ),
                      ]
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5,bottom: 5),
                  child: Container(
                    child: Text("$commentlen yorumun hepsini gör.."),
                  ),
                ),
                Container(
                  child: Text(DateFormat.yMMMd().format(widget.snap["datePublished"].toDate()),style: TextStyle(fontSize: 12),),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
