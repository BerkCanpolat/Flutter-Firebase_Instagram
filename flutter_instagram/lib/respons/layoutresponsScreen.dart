import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_instagram/utils/globalveriables.dart';

class LayoutScreen extends StatelessWidget {
  final Widget webScreen;
  final Widget mobilcreen;
  const LayoutScreen({super.key,required this.webScreen,required this.mobilcreen});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        if(constraints.maxWidth > webSize){
          return webScreen;
        }else{
          return mobilcreen;
        }
      },
    );
  }
}