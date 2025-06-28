import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
    final String hintText;
   final controller;
   final bool obscureText;



  const MyTextfield({
    super.key,
    required this.controller,
    required this .obscureText,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber),
          ),
          focusedBorder:  const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          fillColor: Colors.grey,
          filled: true,
          hintText: hintText,
        ),
      ),
    );

  }
}
