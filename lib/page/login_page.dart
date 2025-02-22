import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:onigokko/viewmodel/login_page_viewmodel.dart';

class LoginPage extends ConsumerWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Emailを入力してください',
                      border: OutlineInputBorder(),
                    ),

                  ),
                ),
              ],),
          ),
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
                    obscureText: true,  // 入力テキストを非表示にする
                    decoration: InputDecoration(
                      labelText: 'パスワードを入力してください',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.visibility_off),  // アイコン（視覚的なヒント）
                    ),),
                ),
              ],),
          ),
          Padding(
            padding: const EdgeInsets.only(top:33.0),
            child: OutlinedButton(
                onPressed: () async {
                  String email = emailController.text;
                  String password = passwordController.text;
                  viewModel.login(email, password).then((ret){
                    if(ret) {
                      viewModel.showToast("ログインしました");
                      context.go("/join");
                    }else{
                      viewModel.showError("ログインできませんでした");
                    }
                  });
                },
                style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    backgroundColor: Colors.white30
                ),
                child: Text("ログイン")
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: TextButton(
                onPressed: ()=>{
                  context.go("/sign_up")
                },
                style: TextButton.styleFrom(foregroundColor: Colors.black),
                child: Text("新規アカウント登録")),
          ),
        ],
      ),
    );
  }
}







