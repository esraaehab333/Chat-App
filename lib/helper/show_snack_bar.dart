
import 'package:chat_app/constants/color.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text , style: TextStyle(color: MyBrown3),),
        backgroundColor: MyBrown1,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
