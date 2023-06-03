import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_instagram/widgets/textField.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

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
              SizedBox(height: 60,),
              Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    maxRadius: 64,
                    backgroundImage: NetworkImage("https://cdn-icons-png.flaticon.com/512/2815/2815428.png"),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 87,
                    child: IconButton(onPressed: (){}, icon: Icon(Icons.add_a_photo)),
                  ),
                ],
              ),
              SizedBox(height: 24,),
              TextFieldWidget(controller: nameController, hintText: "İsim", textInputType: TextInputType.text,textInputAction: TextInputAction.next),
              SizedBox(height: 12,),
              TextFieldWidget(controller: emailController, hintText: "E-posta", textInputType: TextInputType.emailAddress,textInputAction: TextInputAction.next),
              SizedBox(height: 12,),
              TextFieldWidget(controller: passwordController, hintText: "Şifre", textInputType: TextInputType.text,textInputAction: TextInputAction.next,obscureText: true,),
              SizedBox(height: 12,),
              TextFieldWidget(controller: bioController, hintText: "Bio", textInputType: TextInputType.text,textInputAction: TextInputAction.done),
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