import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  const TextFieldWidget(
      {super.key,
      required this.controller,
      required this.hintText,
      this.obscureText = false,
      required this.textInputType,
      required this.textInputAction
      });

  @override
  Widget build(BuildContext context) {
    final _outline =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: controller,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        hintText: hintText,
        border: _outline,
        errorBorder: _outline,
        enabledBorder: _outline,
        focusedBorder: _outline,
        disabledBorder: _outline,
        focusedErrorBorder: _outline,
        filled: true,
      ),
      obscureText: obscureText,
      keyboardType: textInputType,
    );
  }
}
