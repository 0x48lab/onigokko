import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class RegisterPageViewmodel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> register(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        //登録成功
        return true;
      }
    } on FirebaseAuthException catch(e) {
      //ログイン認証エラー
    } catch(e) {
      //その他の例外処理
    }

    return false;
  }
}