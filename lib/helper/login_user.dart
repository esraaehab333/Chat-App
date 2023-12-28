  // ignore_for_file: unused_local_variable

  import 'package:firebase_auth/firebase_auth.dart';

Future<void> loginUser(String email , String password) async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

