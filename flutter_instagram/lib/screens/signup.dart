import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_instagram/resource/auth.dart';
import 'package:flutter_instagram/respons/layoutresponsScreen.dart';
import 'package:flutter_instagram/respons/mobilScreen.dart';
import 'package:flutter_instagram/respons/webScreen.dart';
import 'package:flutter_instagram/screens/login.dart';
import 'package:flutter_instagram/utils/utils.dart';
import 'package:flutter_instagram/widgets/textField.dart';
import 'package:image_picker/image_picker.dart';

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
  Uint8List? _image;
  bool isLoading = false;

  pickSign() async {
    Uint8List _uint = await selectPickImage(ImageSource.gallery);
    setState(() {
      _image = _uint;
    });
  }

  void signUpControl() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethod().signUp(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        bio: bioController.text,
        file: _image!
        );
    setState(() {
      isLoading = false;
    });
        if(res == "Kayıt olundu"){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LayoutScreen(webScreen: WebScreen(), mobilcreen: MobilScreen())));
        }else{
          showSnackBar(context, "Kayıt Başarısız");
        }
  }


  void navigatoControl(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: kToolbarHeight,
              ),
              Image.asset(
                "assets/ins.png",
                height: 90,
              ),
              SizedBox(
                height: 60,
              ),
              Stack(
                children: [
                  _image == null
                      ? CircleAvatar(
                          backgroundColor: Colors.white,
                          maxRadius: 64,
                          backgroundImage: NetworkImage(
                              "https://cdn-icons-png.flaticon.com/512/2815/2815428.png"),
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.white,
                          maxRadius: 64,
                          backgroundImage: MemoryImage(_image!),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 87,
                    child: IconButton(
                        onPressed: pickSign, icon: Icon(Icons.add_a_photo)),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              TextFieldWidget(
                  controller: nameController,
                  hintText: "İsim",
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next),
              SizedBox(
                height: 12,
              ),
              TextFieldWidget(
                  controller: emailController,
                  hintText: "E-posta",
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next),
              SizedBox(
                height: 12,
              ),
              TextFieldWidget(
                controller: passwordController,
                hintText: "Şifre",
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.next,
                obscureText: true,
              ),
              SizedBox(
                height: 12,
              ),
              TextFieldWidget(
                  controller: bioController,
                  hintText: "Bio",
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: signUpControl,
                    child: isLoading ? Center(child: CircularProgressIndicator(color: Colors.white,),) :  Text("Kayıt Ol"),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  child: Row(
                    children: [
                      Text("Zaten bir hesabın var mı?"),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: navigatoControl,
                        child: Text(
                          "Giriş Yap",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
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
