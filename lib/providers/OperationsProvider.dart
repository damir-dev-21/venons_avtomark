import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:venons_automark/models/Item/Item.dart';
import 'package:venons_automark/models/Operation/Operation.dart';

import '../models/Operations/Operations.dart';

class OperationsProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _warehouses = [
    {'id': 1, 'name': 'Склад 1'},
    {'id': 2, 'name': 'Склад 2'},
    {'id': 3, 'name': 'Склад 3'},
    {'id': 4, 'name': 'Склад 4'},
  ];
  final List<Map<String, dynamic>> _clients = [
    {'id': 1, 'name': 'Клиент 1'},
    {'id': 2, 'name': 'Клиент 2'},
    {'id': 3, 'name': 'Клиент 3'},
    {'id': 4, 'name': 'Клиент 4'},
  ];
  List<Operation> _operations = [];

  Future<void> getOperations() async {}

  void addOperations(Operation operation) {
    _operations.add(operation);
    notifyListeners();
  }

  List<Operation> get operations => _operations;
  List<Map<String, dynamic>> get warehouses => _warehouses;
  List<Map<String, dynamic>> get clients => _clients;
}
