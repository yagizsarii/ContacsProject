import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool isText;

  const MyTextField(
      {super.key, required this.hintText, required this.isText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: isText ? TextInputType.text : TextInputType.number,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none)),
    );
  }
}
