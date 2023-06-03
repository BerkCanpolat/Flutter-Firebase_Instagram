import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

selectPickImage(ImageSource source) async{
  final ImagePicker _image = ImagePicker();

  XFile? file = await _image.pickImage(source: source);
  if(file != null){
    return await file.readAsBytes();
  }
  print("Foto yüklerken hata oluştu");
}


showSnackBar(BuildContext context, String text){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text,style: TextStyle(color: Colors.white),),backgroundColor: Colors.black,));
}