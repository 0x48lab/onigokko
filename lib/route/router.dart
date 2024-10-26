import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onigokko/page/login_page.dart';

final goRouter = GoRouter(
  initialLocation: "/login",
  routes: [
    GoRoute(
        path: "/login",
        name: "login",
      pageBuilder: (context, state) {
          return MaterialPage(key: state.pageKey, child: LoginPage());
      }
    )
  ]
);