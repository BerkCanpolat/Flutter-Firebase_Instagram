import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_instagram/firebase_options.dart';
import 'package:flutter_instagram/respons/layoutresponsScreen.dart';
import 'package:flutter_instagram/respons/mobilScreen.dart';
import 'package:flutter_instagram/respons/webScreen.dart';
import 'package:flutter_instagram/screens/login.dart';
import 'package:flutter_instagram/screens/signup.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );
  }else{
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: LayoutScreen(webScreen: WebScreen(), mobilcreen: MobilScreen()),
      home: SignUpScreen(),
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light
        )
      ),
    );
  }
}