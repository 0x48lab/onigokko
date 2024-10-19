import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class LoginPageViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> login(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(userCredential.user != null){
        //ログイン成功
        return true;
      }
    } on FirebaseAuthException catch(e) {
      //ログイン認証エラー
      debugPrintStack();
    } catch(e) {
      //その他の例外処理
    }

    return false;
  }
}