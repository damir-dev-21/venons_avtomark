import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:venons_automark/models/Item/Item.dart';
import 'package:venons_automark/providers/AuthProvider.dart';
import 'package:venons_automark/providers/OperationsProvider.dart';
import 'package:venons_automark/screens/auth_screen.dart';
import 'package:venons_automark/screens/main_screen.dart';
import 'package:venons_automark/screens/operation_screen.dart';

import '../models/Operation/Operation.dart';

class ConnectScreen extends StatelessWidget {
  const ConnectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final OperationsProvider operationsProvider =
        Provider.of<OperationsProvider>(context, listen: false);
    final List<Operation> operations = operationsProvider.operations;
    // return authProvider.isAuth ? const MainScreen() : AuthScreen();
    return MainScreen();
  }
}
