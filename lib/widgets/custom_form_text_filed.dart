

// ignore_for_file: must_be_immutable

import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class CustomFormTextFiled extends StatelessWidget {
  CustomFormTextFiled({super.key, required this.hintText, this.onChanged});
  final String hintText;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return "field is requied";
        }
        return null;
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(15),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: FoucseBorderSideColor, width: 2.0),
          borderRadius: const BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: EnableBorderSideColor, width: 1.0),
          borderRadius: const BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        hintText: hintText,
      ),
    );
  }
}
