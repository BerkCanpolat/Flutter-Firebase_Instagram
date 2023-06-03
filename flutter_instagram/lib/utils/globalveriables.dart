import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/screens/addPostScreen.dart';
import 'package:flutter_instagram/screens/feedScreen.dart';
import 'package:flutter_instagram/screens/profile.dart';
import 'package:flutter_instagram/screens/search.dart';

const webSize = 600;

var pageChange = [
  FeedScreenDart(),
SearchScreen(),
  AddPostScreen(),
  Center(
    child: Text("Favourite"),
  ),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,),
];
