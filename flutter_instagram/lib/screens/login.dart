import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_instagram/resource/auth.dart';
import 'package:flutter_instagram/respons/layoutresponsScreen.dart';
import 'package:flutter_instagram/respons/mobilScreen.dart';
import 'package:flutter_instagram/respons/webScreen.dart';
import 'package:flutter_instagram/screens/signup.dart';
import 'package:flutter_instagram/utils/utils.dart';
import 'package:flutter_instagram/widgets/textField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;


  void loginControl() async{
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethod().login(emailController.text, passwordController.text);
    if(res != "Giriş Başarılı"){
      showSnackBar(context, "Giriş Başarısız");
    }else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LayoutScreen(webScreen: WebScreen(), mobilcreen: MobilScreen())));
    }
    setState(() {
      isLoading = false;
    });
  }

    void navigatoControl(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignUpScreen()));
  }

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
                height: 45,
                child: ElevatedButton(
                  onPressed: loginControl, 
                  child: isLoading ? Center(child: CircularProgressIndicator(color: Colors.white,),) : Text("Giriş Yap"),
                  )
                  ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  child: Row(
                    children: [
                      Text("Henüz bir hesabın yok mu?"),
                      SizedBox(width: 5,),
                      InkWell(
                        onTap: navigatoControl,
                        child: Text("Kaydol",style: TextStyle(fontWeight: FontWeight.bold),)),
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