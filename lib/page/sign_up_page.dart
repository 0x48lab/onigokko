import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatelessWidget{
  const SignUpPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("アカウント登録", style: TextStyle(fontSize: 32)),
          Padding(
            padding: const EdgeInsets.only(top: 22.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 70,
                    child: Text("ユーザー名", style: TextStyle(fontSize: 12))),
                SizedBox(
                  width: 227,
                  child: TextField(
                    controller: TextEditingController(),
                    decoration: InputDecoration(
                      labelText: 'Enter your username',
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
                    child: Text("メールアドレス", style: TextStyle(fontSize: 12))),
                SizedBox(
                  width: 227,
                  child: TextField(
                    controller: TextEditingController(),
                    decoration: InputDecoration(
                      labelText: 'Enter your e-mail',
                      border: OutlineInputBorder(),
                    ),),
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
                    controller: TextEditingController(),
                    decoration: InputDecoration(
                      labelText: 'Enter your password',
                      border: OutlineInputBorder(),
                    ),),
                ),
              ],),
          ),
          Padding(
            padding: const EdgeInsets.only(top:33.0),
            child: OutlinedButton(
                onPressed: ()=>{
                  context.go("/join")
                },
                style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    backgroundColor: Colors.white30
                ),
                child: Text("登録")
            ),
          ),
          /** Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: TextButton(
                onPressed: ()=>{},
                style: TextButton.styleFrom(foregroundColor: Colors.black),
                child: Text("新規アカウント登録")),
          ), **/
        ],
      ),
    );
  }
  
}