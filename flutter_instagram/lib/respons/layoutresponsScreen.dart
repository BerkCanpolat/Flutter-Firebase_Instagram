import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_instagram/provider/provider.dart';
import 'package:flutter_instagram/utils/globalveriables.dart';
import 'package:provider/provider.dart';

class LayoutScreen extends StatefulWidget {
  final Widget webScreen;
  final Widget mobilcreen;
  const LayoutScreen({super.key,required this.webScreen,required this.mobilcreen});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addUse();
  }

  addUse() async{
    InsProvider insProvider = Provider.of(context,listen: false);
    await insProvider.userRefResh();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        if(constraints.maxWidth > webSize){
          return widget.webScreen;
        }else{
          return widget.mobilcreen;
        }
      },
    );
  }
}