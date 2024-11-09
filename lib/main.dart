import 'package:flutter/material.dart';
import 'package:onigokko/page/join_page.dart';
import 'package:onigokko/route/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: goRouter.routerDelegate,
      routeInformationParser: goRouter.routeInformationParser,
      routeInformationProvider: goRouter.routeInformationProvider,

      title: '鬼ごっこ',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      // home: const AccoutScreen(),
    );
  }
}

