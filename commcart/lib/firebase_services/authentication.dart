import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future createAccountWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return 'account created';
    } on FirebaseAuthException {
      await isExistingUser(email);
    }
  }

  Future loginWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return 'Login Succesful';
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return 'Mail sent';
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future<bool> isLoggedIn() async {
    var user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  Future isExistingUser(String email) async {
    await FirebaseAuth.instance
        .fetchSignInMethodsForEmail(email)
        .then((methods) {
      if (methods.isNotEmpty) {
        return 'User already exist';
      } else {
        return null;
      }
    });
  }
}
