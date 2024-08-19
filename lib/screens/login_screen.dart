// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/constants/color.dart';
import 'package:chat_app/cubits/login_cubit/login_cubit.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_form_text_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable, use_key_in_widget_constructors
class LoginScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();
  String? email;

  String? password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                  email: email!,
                ),
              ));
              isLoading = false;
        }
        else{
          showSnackBar(context, "some thing want wrong");
          isLoading = false;
        }
      },
      builder: (context , state)=> ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  const Image(
                    image:
                        AssetImage("assets/images/Cat astronaut-cuate (2).png"),
                    height: 300,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "LOGIN",
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
                    lable: "Login",
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<LoginCubit>(context).loginUser(email: email!, password: password!);
                      } 
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("don't have an account ? "),
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ),
                          ),
                        },
                        child: Text(
                          "register",
                          style: TextStyle(color: MyPurple3),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
