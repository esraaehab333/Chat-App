// ignore_for_file: unused_local_variable

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> registerUser(String email, String password) async {
    emit(RegisterLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == "weak-password") {
        emit(RegisterFailure(errMsg: "weak password"));
      } else if (ex.code == "email-already-in-use") {
        emit(RegisterFailure(errMsg: "email already exist"));
      }
    } catch (e) {
      emit(
        RegisterFailure(errMsg: "there was an error pleas try again"),
      );
    }
  }
}
