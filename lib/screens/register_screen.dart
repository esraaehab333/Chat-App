// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/register_user.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_form_text_filed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: WhiteColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 75,
                ),
                const Image(
                  image: AssetImage("assets/images/chatt.jpg"),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "REGISTER",
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomFormTextFiled(
                  hintText: "enter your email",
                  onChanged: (data) {
                    email = data;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomFormTextFiled(
                  hintText: "enter your password",
                  onChanged: (data) {
                    password = data;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomButton(
                  lable: "Register",
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await registerUser(email!, password!);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  ChatScreen(),
                          ),
                        );
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == "weak-password") {
                          showSnackBar(context, "weak password");
                        } else if (ex.code == "email-already-in-use") {
                          showSnackBar(context, "email already exist");
                        }
                      } catch (ex) {
                        showSnackBar(context, "there was an error");
                      }
                      isLoading = false;
                      setState(() {});
                    } else {}
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("have an account ? "),
                    GestureDetector(
                      onTap: () => {
                        Navigator.pop(context),
                      },
                      child: Text(
                        "login",
                        style: TextStyle(color: EnableBorderSideColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
