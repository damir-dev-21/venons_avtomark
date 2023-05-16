import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:venons_automark/screens/auth_screen.dart';
import 'package:venons_automark/screens/main_screen.dart';
import 'package:venons_automark/screens/operation_screen.dart';
import '../models/Operation/Operation.dart';
import '../screens/connect_screen.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: ConnectScreen, initial: true),
    AutoRoute(page: AuthScreen),
    AutoRoute(page: MainScreen),
    AutoRoute(page: OperationScreen),
  ],
)
class AppRouter extends _$AppRouter {}
