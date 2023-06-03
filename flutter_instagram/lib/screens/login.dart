import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_instagram/widgets/textField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: kToolbarHeight,),
              Image.asset("assets/ins.png",height: 90,),
              SizedBox(height: 64,),
              TextFieldWidget(controller: emailController, hintText: "E-posta", textInputType: TextInputType.emailAddress,textInputAction: TextInputAction.next),
              SizedBox(height: 12,),
              TextFieldWidget(controller: passwordController, hintText: "Şifre", textInputType: TextInputType.text,textInputAction: TextInputAction.done,obscureText: true,),
              SizedBox(height: 20,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: (){}, child: Text("Giriş Yap"),)),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  child: Row(
                    children: [
                      Text("Henüz bir hesabın yok mu?"),
                      SizedBox(width: 5,),
                      Text("Kaydol",style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}