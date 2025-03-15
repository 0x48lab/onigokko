import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

class JoinPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JoinPage();
}

class _JoinPage extends ConsumerState<JoinPage> {

  @override
  void initState() {
    super.initState();

    _checkAndRequestPermission();
  }

  Future<void> _checkAndRequestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    print("permission = $permission");
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      _showSettingsDialog(); // ユーザーに設定を促す
    }
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("位置情報の許可が必要"),
        content: Text("この機能を使用するには位置情報の許可が必要です。設定を開いて変更してください。"),
        actions: [
          TextButton(
            child: Text("キャンセル"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text("設定を開く"),
            onPressed: () {
              Geolocator.openAppSettings();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("鬼ごっこ", style: TextStyle(fontSize: 32)),
          Padding(
            padding: const EdgeInsets.only(top: 22.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              SizedBox(
                width: 70,
                  child: Text("部屋ID", style: TextStyle(fontSize: 12))),
              SizedBox(
                width: 227,
                child: TextField(
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                  labelText: 'Enter your name',
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
            child: OutlinedButton(
                onPressed: ()=>{
                  context.go("/map_page")
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  backgroundColor: Colors.white30
                ),
                child: Text("参加する")
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: TextButton(
                onPressed: ()=>{
                  context.go("/map_page")
                },
                style: TextButton.styleFrom(foregroundColor: Colors.black),
                child: Text("新しい部屋を作る")),
          ),
        ],
      ),
    );
  }
}