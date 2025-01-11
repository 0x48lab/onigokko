import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onigokko/page/join_page.dart';
import 'package:onigokko/page/login_page.dart';
import 'package:onigokko/page/map_page.dart';
import 'package:onigokko/page/sign_up_page.dart';

final goRouter = GoRouter(
  initialLocation: "/login",
  routes: [
    GoRoute(
        path: "/login",
        name: "login",
      pageBuilder: (context, state) {
          return MaterialPage(key: state.pageKey, child: LoginPage());
      }
    ),
    GoRoute(
        path: "/join",
        name: "join",
        pageBuilder: (context, state) {
          return MaterialPage(key: state.pageKey, child: JoinPage());
        }
    ),
    GoRoute(
        path: "/sign_up",
        name: "sign_up",
        pageBuilder: (context, state) {
          return MaterialPage(key: state.pageKey, child: SignUpPage());
        }
    ),
    GoRoute(
        path: "/map_page",
        name: "map_page",
        pageBuilder: (context, state) {
          return MaterialPage(key: state.pageKey, child: MapPage());
        }
    ),
  ]
);