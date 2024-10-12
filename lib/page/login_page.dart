import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("鬼ごっこ", style: TextStyle(fontSize: 32,),),
          Padding(
            padding: const EdgeInsets.only(top: 22.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              SizedBox(
                width: 70,
                  child: Text("部屋ID", style: TextStyle(fontSize: 12),)),
              SizedBox(
                width: 227,
                child: TextField(
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                  labelText: 'Enter your name',
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
                  labelText: 'Enter your name',
                  border: OutlineInputBorder(),
                ),),
              ),
            ],),
          ),
          Padding(
            padding: const EdgeInsets.only(top:33.0),
            child: OutlinedButton(onPressed: ()=>{}, child: Text("参加する")),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: TextButton(onPressed: ()=>{}, child: Text("新しい部屋を作る")),
          ),
        ],
      ),
    );
  }
  
}