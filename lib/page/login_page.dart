import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:onigokko/viewmodel/login_page_viewmodel.dart';

class LoginPage extends ConsumerStatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  List<String> emailHistory = []; // 過去の入力履歴
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _loadEmailHistory();
  }

  /// 過去に入力したメールアドレスを取得
  Future<void> _loadEmailHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      emailHistory = prefs.getStringList('email_history') ?? [];
    });
  }

  /// メールアドレスを履歴に保存（重複しないようにする）
  Future<void> _saveEmailToHistory(String email) async {
    if (email.isEmpty) return;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (!emailHistory.contains(email)) {
        emailHistory.insert(0, email); // 先頭に追加
        if (emailHistory.length > 5) {
          emailHistory = emailHistory.sublist(0, 5); // 最大5件まで保存
        }
      }
    });
    await prefs.setStringList('email_history', emailHistory);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginProvider);
    final viewModel = ref.read(loginProvider.notifier);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("ログイン", style: TextStyle(fontSize: 32)),

          Padding(
            padding: const EdgeInsets.only(top: 22.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 70,
                    child: Text("メールアドレス", style: TextStyle(fontSize: 12))),
                SizedBox(
                  width: 227,
                  child: Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<String>.empty();
                      }
                      return emailHistory.where((email) =>
                          email.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                    },
                    onSelected: (String selection) {
                      emailController.text = selection;
                    },
                    fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
                      emailController.text = controller.text; // Controllerと同期
                      return TextField(
                        controller: controller,
                        focusNode: focusNode,
                        decoration: InputDecoration(
                          labelText: 'Emailを入力してください',
                          border: OutlineInputBorder(),
                        ),
                        onEditingComplete: onEditingComplete,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          /// 🔑 パスワードの入力欄（目のアイコン付き）
          Padding(
            padding: const EdgeInsets.only(top: 22.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 70,
                    child: Text("パスワード", style: TextStyle(fontSize: 12))),
                SizedBox(
                  width: 227,
                  child: TextField(
                    controller: passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'パスワードを入力してください',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 33.0),
            child: OutlinedButton(
                onPressed: () async {
                  String email = emailController.text;
                  String password = passwordController.text;

                  viewModel.login(email, password).then((ret) {
                    if (ret) {
                      viewModel.showToast("ログインしました");
                      _saveEmailToHistory(email); // 成功したら履歴に追加
                      context.go("/join");
                    } else {
                      viewModel.showError("ログインできませんでした");
                    }
                  });
                },
                style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    backgroundColor: Colors.white30),
                child: Text("ログイン")),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: TextButton(
                onPressed: () => {context.go("/sign_up")},
                style: TextButton.styleFrom(foregroundColor: Colors.black),
                child: Text("新規アカウント登録")),
          ),
        ],
      ),
    );
  }
}
