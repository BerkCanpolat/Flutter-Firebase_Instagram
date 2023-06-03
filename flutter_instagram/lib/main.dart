import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_instagram/firebase_options.dart';
import 'package:flutter_instagram/provider/provider.dart';
import 'package:flutter_instagram/respons/layoutresponsScreen.dart';
import 'package:flutter_instagram/respons/mobilScreen.dart';
import 'package:flutter_instagram/respons/webScreen.dart';
import 'package:flutter_instagram/screens/login.dart';
import 'package:flutter_instagram/screens/signup.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InsProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.active){
              if(snapshot.hasData){
                return LayoutScreen(webScreen: WebScreen(), mobilcreen: MobilScreen());
              }else if(snapshot.hasError){
                return Center(child: Text("${snapshot.error}"),);
              }
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            return LoginScreen();
          },
        ),
        theme: ThemeData.light().copyWith(
          appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.light,
            elevation: 0.0,
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(color: Colors.black
            ),
            iconTheme: IconThemeData(color: Colors.black)
          )
        ),
      ),
    );
  }
}