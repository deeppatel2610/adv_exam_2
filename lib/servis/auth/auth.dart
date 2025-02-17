import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  Auth._();

  static Auth auth = Auth._();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> singUp({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      return e.toString();
    }
    return "";
  }

  Future<String> singIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      return e.toString();
    }
    return "";
  }
}
