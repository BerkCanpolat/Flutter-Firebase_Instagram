import 'package:flutter/material.dart';
import 'package:flutter_instagram/model/user.dart';
import 'package:flutter_instagram/resource/auth.dart';

class InsProvider with ChangeNotifier{
  UserModel? _user;
  final AuthMethod _authMethod = AuthMethod();

  UserModel? get getUser => _user;

  Future<void> userRefResh() async{
    UserModel? user = await _authMethod.userDetails();
    _user = user;
    notifyListeners();
  }
}