import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';

final registerProvider =
StateNotifierProvider<RegisterPageViewmodel, RegisterState>(
      (ref) => RegisterPageViewmodel(),
);

class RegisterPageViewmodel extends StateNotifier<RegisterState> {
  RegisterPageViewmodel()
      : super(RegisterState()); // 初期状態を設定

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// ユーザー登録
  Future<bool> register(String email, String password, String name) async {
    if (!_validateInputs(email, password, name)) {
      return false;
    }

    state = state.copyWith(isLoading: true); // ローディング状態開始
    try {
      // Firebase Authenticationでユーザー作成
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user?.uid;

      if (uid != null) {
        // Firestoreにユーザー情報を保存
        await _saveUserToFirestore(uid, email, name);
        state = state.copyWith(isLoading: false, errorMessage: null); // 成功時にエラーをクリア
        return true;
      }
    } on FirebaseAuthException catch (e) {
      _handleFirebaseAuthError(e);
    } catch (_) {
      state = state.copyWith(errorMessage: '登録中に予期しないエラーが発生しました。');
    } finally {
      state = state.copyWith(isLoading: false); // ローディング状態終了
    }
    return false;
  }

  /// 入力データのバリデーション
  bool _validateInputs(String email, String password, String name) {
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      state = state.copyWith(errorMessage: 'すべてのフィールドを入力してください。');
      return false;
    }
    if (password.length < 6) {
      state = state.copyWith(errorMessage: 'パスワードは6文字以上で入力してください。');
      return false;
    }
    state = state.copyWith(errorMessage: null); // バリデーションエラーなし
    return true;
  }

  /// Firestoreにユーザー情報を保存
  Future<void> _saveUserToFirestore(String uid, String email, String name) async {
    await _firestore.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Firebase認証エラーを処理
  void _handleFirebaseAuthError(FirebaseAuthException e) {
    String errorMessage;
    switch (e.code) {
      case 'email-already-in-use':
        errorMessage = 'このメールアドレスは既に使用されています。';
        break;
      case 'invalid-email':
        errorMessage = '無効なメールアドレスです。';
        break;
      case 'weak-password':
        errorMessage = 'パスワードが弱すぎます。';
        break;
      default:
        errorMessage = '登録中にエラーが発生しました。';
    }
    state = state.copyWith(errorMessage: errorMessage);
  }
}

/// ViewModelの状態を定義
class RegisterState {
  final bool isLoading;
  final String? errorMessage;

  RegisterState({this.isLoading = false, this.errorMessage});

  RegisterState copyWith({bool? isLoading, String? errorMessage}) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}