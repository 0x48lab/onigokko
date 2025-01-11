import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("仮置き(マップ用)", style: TextStyle(fontSize: 32)),
          Padding(
            padding: const EdgeInsets.only(top: 22.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 70,
                    child: Text("---", style: TextStyle(fontSize: 12))),
                SizedBox(
                  width: 227,
                  child: TextField(
                    controller: TextEditingController(),
                    decoration: InputDecoration(
                      labelText: '---',
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
                    child: Text("---", style: TextStyle(fontSize: 12))),
                SizedBox(
                  width: 227,
                  child: TextField(
                    controller: TextEditingController(),
                    decoration: InputDecoration(
                      labelText: '---',
                      border: OutlineInputBorder(),
                    ),),
                ),
              ],),
          ),
          Padding(
            padding: const EdgeInsets.only(top:33.0),
            child: OutlinedButton(
                onPressed: ()=>{},
                style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    backgroundColor: Colors.white30
                ),
                child: Text("---")
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: TextButton(
                onPressed: ()=>{},
                style: TextButton.styleFrom(foregroundColor: Colors.black),
                child: Text("---")),
          ),
        ],
      ),
    );
  }
}