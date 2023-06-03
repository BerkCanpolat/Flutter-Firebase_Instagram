import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MobilScreen extends StatefulWidget {
  const MobilScreen({super.key});

  @override
  State<MobilScreen> createState() => _MobilScreenState();
}

class _MobilScreenState extends State<MobilScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("mobil ekranı"),),
    );
  }
}