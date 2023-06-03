import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatelessWidget {
  final snap;
  const CommentCard({super.key,required this.snap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 18),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(snap["profilePic"]),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: snap["name"],style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                        TextSpan(
                          text: "  ${snap["text"]}"
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(DateFormat.yMMMd().format(snap["datePublished"].toDate()),style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
          ),
          Container(
            child: Icon(Icons.favorite,size: 15,),
          )
        ],
      ),
    );
  }
}