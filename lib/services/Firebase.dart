import 'package:firebase_auth/firebase_auth.dart';

class Firebase {

  Future singIn(email, password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  }
}