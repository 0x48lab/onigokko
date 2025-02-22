import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:onigokko/service/provider.dart';
import 'package:onigokko/viewmodel/register_page_viewmodel.dart';

class SignUpPage extends ConsumerWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ViewModelの状態を取得
    final state = ref.watch(registerProvider);
    final viewModel = ref.read(registerProvider.notifier);

    // 各TextFieldのコントローラー
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: BackButton(
                  onPressed: () => {context.go("/login")},
                  color: Colors.black,
                ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("アカウント登録", style: TextStyle(fontSize: 32)),
                  _buildTextField("ユーザー名", "Enter your username", nameController),
                  _buildTextField("メールアドレス", "Enter your e-mail", emailController),
                  _buildTextField(
                      "パスワード", "Enter your password", passwordController,
                      obscureText: true),
                  Padding(
                    padding: const EdgeInsets.only(top: 33.0),
                    child: OutlinedButton(
                      onPressed: state.isLoading
                          ? null
                          : () async {
                              final name = nameController.text.trim();
                              final email = emailController.text.trim();
                              final password = passwordController.text.trim();
              
                              final success =
                                  await viewModel.register(email, password, name);
              
                              if (success) {
                                context.go("/join"); // 登録成功時にページ遷移
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text(state.errorMessage ?? '登録に失敗しました。'),
                                  ),
                                );
                              }
                            },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                        backgroundColor: Colors.white30,
                      ),
                      child: state.isLoading
                          ? const CircularProgressIndicator(color: Colors.black)
                          : const Text("登録"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// テキストフィールドのUI構築
  Widget _buildTextField(
      String label, String hint, TextEditingController controller,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 22.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: 70,
              child: Text(label, style: const TextStyle(fontSize: 12))),
          SizedBox(
            width: 227,
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(
                labelText: hint,
                border: const OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
