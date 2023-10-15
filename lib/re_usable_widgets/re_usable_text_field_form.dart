import 'package:flutter/material.dart';
import 'package:student_information/home_page.dart';

class ReUsableTextFieldForm extends StatelessWidget {
  ReUsableTextFieldForm({
    required this.text,
    this.icon,
    this.controller,
    this.onTap,
    required this.inputType,
  });

  String text;
  Widget? icon;
  VoidCallback? onTap;
  TextInputType inputType;
  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      child: TextFormField(
        onTap: onTap,
        controller: controller,
        keyboardType: inputType,
        cursorColor: Colors.black,
        style: myStyle(20, FontWeight.normal, Colors.black),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            focusColor: Colors.transparent,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            suffixIcon: icon,
            hintText: text,
            hintStyle: myStyle(16, FontWeight.normal, Colors.grey)),
      ),
    );
  }
}
