// ignore_for_file: unused_local_variable

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-login-credentials') {
        emit(
          LoginFailure(arrMsg: 'user not found'),
         );
      } else if (e.code == 'wrong-password') {
        emit(
          LoginFailure(arrMsg: 'wrong password'),
        );
      }
    // ignore: unused_catch_clause
    } on Exception catch (e) {
      emit(
        LoginFailure(arrMsg: 'something want wrong'),
      );
    }
  }
}
