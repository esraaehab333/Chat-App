// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:chat_app/constants/color.dart';
import 'package:chat_app/cubits/register_cubit/register_cubit.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_form_text_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: use_key_in_widget_constructors
class RegisterScreen extends StatelessWidget {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                  email: email!,
                ),
              ));
          isLoading = false;
        } else {
          showSnackBar(context, "some thing want wrong");
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: MyGray,
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
                      image: AssetImage(
                          "assets/images/Cat astronaut-pana (1).png"),
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
                          BlocProvider.of<RegisterCubit>(context)
                              .registerUser(email!, password!);
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
                            style: TextStyle(color: MyPurple3),
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
      },
    );
  }
}
