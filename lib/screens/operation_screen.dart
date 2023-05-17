import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:venons_automark/constants/colors.dart';
import 'package:venons_automark/models/Item/Item.dart';
import 'package:venons_automark/models/Operation/Operation.dart';
import 'package:venons_automark/providers/OperationsProvider.dart';

class OperationScreen extends StatefulWidget {
  const OperationScreen({Key? key, required this.operation}) : super(key: key);

  final Operation operation;
  @override
  State<OperationScreen> createState() => _OperationScreenState();
}

class _OperationScreenState extends State<OperationScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  TextEditingController _controller = TextEditingController();
  final KeyboardVisibilityController _keyboardVisibilityController =
      KeyboardVisibilityController();
  FocusNode _textFocusNode = FocusNode();
  Barcode? result;
  QRViewController? controller;
  String comment = '';
  Map<String, dynamic> warehouse = {};
  Map<String, dynamic> client = {};
  List<Item> items = [];
  bool _status = true;
  List<DataRow> rows = [];
  String _scanText = '';
  bool _isAdd = false;
  String _finalScanStr = "";
  late var formKey;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    ServicesBinding.instance.keyboard.addHandler(_onKey);

    warehouse = widget.operation.warehouse;
    client = widget.operation.client;
    comment = widget.operation.comment;
    items = widget.operation.items;
    rows = items
        .map((e) => DataRow(
              cells: [
                DataCell(Center(child: Text(e.id.toString()))),
                DataCell(Text(e.name)),
                DataCell(Text(e.announce.toString())),
                DataCell(Text(e.scanned.toString())),
              ],
            ))
        .toList();
  }

  bool _onKey(KeyEvent event) {
    final key = event.logicalKey.keyLabel;

    if (event is KeyDownEvent) {
      if (key.characters.toString() != 'Enter') {
        setState(() {
          _finalScanStr = _finalScanStr + key.characters.toString();
        });
        print(key.characters);
      } else {
        Map<String, dynamic> _item = {
          'name': _finalScanStr,
          'announce': 0,
          'scanned': 0
        };
        _addToTable(_item);
      }
    }

    return false;
  }

  _addToTable(Map<String, dynamic> item) {
    setState(() {
      _isAdd = true;
      items.add(Item(items.length + 1, "", item['name'], item['announce'],
          item['scanned']));
      _updateRows(Item(items.length + 1, "", item['name'], item['announce'],
          item['scanned']));
      _finalScanStr = '';
    });
  }

  _showScanner() {
    var scanArea = 150.0;
    return StatefulBuilder(builder: (context, StateSetter setState) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          height: 300,
          child: QRView(
            key: qrKey,
            onQRViewCreated: (e) {
              _onQRViewCreated(e, context);
            },
            overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: scanArea),
            onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
          ),
        ),
      );
    });
  }

  _onQRViewCreated(QRViewController controller, BuildContext contexts) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        _isAdd = false;
      });
      setState(() {
        items.add(
            Item(items.length + 1, 'gtin', result!.code.toString(), 10, 0));
        rows = items
            .map((e) => DataRow(
                  cells: [
                    DataCell(Center(child: Text(e.id.toString()))),
                    DataCell(Text(e.name)),
                    DataCell(Text(e.announce.toString())),
                    DataCell(Text(e.scanned.toString())),
                  ],
                ))
            .toList();
      });
      Navigator.pop(contexts);
      controller.dispose();
    });
  }

  _updateRows(Item item) {
    items.firstWhere((e) => e.id == items.length).name = item.name;
    rows = items
        .map((e) => DataRow(
              cells: [
                DataCell(Center(child: Text(e.id.toString()))),
                DataCell(Text(e.name)),
                DataCell(Text(e.announce.toString())),
                DataCell(Text(e.scanned.toString())),
              ],
            ))
        .toList();
    setState(() {
      _isAdd = false;
    });
  }

  _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    ServicesBinding.instance.keyboard.removeHandler(_onKey);
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final OperationsProvider operationsProvider =
        Provider.of<OperationsProvider>(context);
    final List<Operation> operations = operationsProvider.operations;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
          child: BarcodeKeyboardListener(
        bufferDuration: Duration(milliseconds: 500),
        onBarcodeScanned: (barcode) {
          print("barcode: " + barcode);
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => saveBtnColor)),
                        onPressed: () {
                          operationsProvider.addOperations(Operation(
                              operations.isNotEmpty
                                  ? operations[operations.length - 1].number + 1
                                  : 1,
                              operations.isNotEmpty
                                  ? operations[operations.length - 1].number + 1
                                  : 1,
                              widget.operation.status,
                              warehouse,
                              client,
                              comment,
                              items,
                              DateFormat("dd.MM.yy HH:mm")
                                  .format(DateTime.now()),
                              false));
                        },
                        child: const Text(
                          'Сохранить',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => saleBtnColor)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Назад',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: logoTextColor),
                    borderRadius: BorderRadius.circular(5)),
                width: MediaQuery.of(context).size.width - 20,
                child: DropdownButton(
                    isExpanded: true,
                    alignment: Alignment.centerLeft,
                    hint: const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text('Клиент'),
                    ),
                    value: client,
                    underline: const SizedBox(),
                    items: operationsProvider.clients.map((e) {
                      return DropdownMenuItem(
                          value: e,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(e['name']),
                          ));
                    }).toList(),
                    onChanged: (e) {
                      setState(() {
                        client = e!;
                      });
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: logoTextColor),
                    borderRadius: BorderRadius.circular(5)),
                width: MediaQuery.of(context).size.width - 20,
                child: DropdownButton(
                    focusNode: _textFocusNode,
                    isExpanded: true,
                    alignment: Alignment.centerLeft,
                    hint: const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text('Склад'),
                    ),
                    underline: const SizedBox(),
                    value: warehouse,
                    items: operationsProvider.warehouses.map((e) {
                      return DropdownMenuItem(
                          value: e,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(e['name']),
                          ));
                    }).toList(),
                    onChanged: (e) {
                      setState(() {
                        warehouse = e!;
                      });
                      _textFocusNode.unfocus();
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextField(
                      autofocus: false,
                      focusNode: _textFocusNode,
                      keyboardType: TextInputType.text,
                      key: const ValueKey('comment'),
                      onChanged: (e) {
                        setState(() {
                          comment = e;
                        });
                      },
                      onEditingComplete: () {
                        _textFocusNode.unfocus();
                      },
                      decoration: InputDecoration(
                          hintText: "Примечание",
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: logoTextColor),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 5),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: DataTable2(
                    // border: TableBorder.all(width: 0.5),
                    columnSpacing: 0,
                    horizontalMargin: 0,
                    columns: [
                      DataColumn(
                          label: SizedBox(
                        width: MediaQuery.of(context).size.width * .3,
                        child: TextButton(
                            onPressed: () {
                              if (_isAdd) {
                                return;
                              }
                              setState(() {
                                _isAdd = true;
                                items.add(Item(items.length + 1, "", "", 0, 0));

                                rows.add(DataRow(
                                  cells: [
                                    DataCell(Center(
                                        child:
                                            Text((items.length).toString()))),
                                    DataCell(TextField(
                                      onEditingComplete: () {
                                        _updateRows(Item(items.length + 1, "",
                                            _scanText, 0, 0));
                                        setState(() {
                                          _isAdd = true;
                                          items.add(Item(
                                              items.length + 1, "", "", 0, 0));

                                          rows.add(DataRow(
                                            cells: [
                                              DataCell(Center(
                                                  child: Text((items.length)
                                                      .toString()))),
                                              DataCell(TextField(
                                                onEditingComplete: () {
                                                  _updateRows(Item(
                                                      items.length + 1,
                                                      "",
                                                      _scanText,
                                                      0,
                                                      0));
                                                },
                                                onChanged: (e) {
                                                  setState(() {
                                                    _scanText = e;
                                                  });
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                        label: Text(""),
                                                        contentPadding:
                                                            EdgeInsets.all(0)),
                                                autofocus: true,
                                                keyboardType:
                                                    TextInputType.text,
                                              )),
                                              const DataCell(Text("0")),
                                              const DataCell(Text("0")),
                                            ],
                                          ));
                                        });
                                      },
                                      onChanged: (e) {
                                        setState(() {
                                          _scanText = e;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                          label: Text(""),
                                          contentPadding: EdgeInsets.all(0)),
                                      autofocus: true,
                                      keyboardType: TextInputType.text,
                                    )),
                                    const DataCell(Text("0")),
                                    const DataCell(Text("0")),
                                  ],
                                ));
                              });
                            },
                            child: const Center(
                              child: Text(
                                '+',
                                style: TextStyle(color: Colors.green),
                              ),
                            )),
                      )),
                      DataColumn(
                          label: SizedBox(
                              width: MediaQuery.of(context).size.width * .3,
                              child: const Text('Товар'))),
                      DataColumn(
                          label: SizedBox(
                              width: MediaQuery.of(context).size.width * .3,
                              child: const Text('Заявлено'))),
                      DataColumn(
                          label: SizedBox(
                              width: MediaQuery.of(context).size.width * .3,
                              child: const Text('Сканировано'))),
                    ],
                    rows: rows),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return _showScanner();
                              });
                        },
                        icon: const Icon(
                          Icons.camera_alt,
                          size: 40,
                        )),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  _status = !_status;
                                });
                              },
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: _status
                                          ? Colors.blueGrey
                                          : logoTextColor),
                                  child: const Center(
                                      child: Text(
                                    "+ Добавить",
                                    style: TextStyle(color: Colors.white),
                                  )))),
                          const SizedBox(
                            width: 1,
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  _status = !_status;
                                });
                              },
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: !_status
                                          ? Colors.blueGrey
                                          : logoTextColor),
                                  child: const Center(
                                      child: Text(
                                    "- Удалить",
                                    style: TextStyle(color: Colors.white),
                                  )))),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
