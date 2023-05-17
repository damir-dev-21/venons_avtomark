import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:venons_automark/constants/colors.dart';
import 'package:venons_automark/models/Operation/Operation.dart';
import 'package:venons_automark/providers/OperationsProvider.dart';
import 'package:venons_automark/routes/router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:device_info_plus/device_info_plus.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<ScanResult> _deviceList = [];
  late BluetoothDevice selectedDevice;
  late BluetoothCharacteristic selectedCharacteristic;
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  final flutterBlue = FlutterBluePlus.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final OperationsProvider operationsProvider =
        Provider.of<OperationsProvider>(context);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => saleBtnColor)),
                          onPressed: () {
                            showTypeOfOperations(context);
                          },
                          child: Text(
                            'Добавить',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.calendar_month)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.sync)),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.account_circle,
                      size: 30,
                    ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height - 135,
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                              itemCount: operationsProvider.operations.length,
                              itemBuilder: (context, index) {
                                final Operation operation =
                                    operationsProvider.operations[index];
                                final documentStatus = operation.status == 0
                                    ? 'Продажа'
                                    : 'Перемещение';
                                final documentDate = operation.date;
                                final documentNumber = operation.number;
                                return ListTile(
                                  onTap: () {
                                    print(operation.warehouse);
                                    print(operation.client);
                                    context.router.push(
                                        OperationRoute(operation: operation));
                                  },
                                  shape: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: logoTextColor)),
                                  style: ListTileStyle.drawer,
                                  title: Text(
                                      '$documentStatus №$documentNumber от $documentDate'),
                                  trailing: operation.success
                                      ? Icon(
                                          Icons.done,
                                          color: saveBtnColor,
                                          size: 20,
                                        )
                                      : Icon(
                                          Icons.close_sharp,
                                          color: saleBtnColor,
                                          size: 20,
                                        ),
                                );
                              })),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}

Future<void> showTypeOfOperations(BuildContext contexts) async {
  final OperationsProvider operationsProvider =
      Provider.of<OperationsProvider>(contexts, listen: false);
  final List<Operation> operations = operationsProvider.operations;
  await showDialog(
      barrierDismissible: true,
      context: contexts,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 0),
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Column(
              children: [
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        contexts.router.push(OperationRoute(
                            operation: Operation(
                                operations.isNotEmpty
                                    ? operations[operations.length - 1].number +
                                        1
                                    : 1,
                                operations.isNotEmpty
                                    ? operations[operations.length - 1].number +
                                        1
                                    : 1,
                                0,
                                operationsProvider.warehouses[0],
                                operationsProvider.clients[0],
                                "",
                                [],
                                DateFormat("dd.MM.yy HH:mm")
                                    .format(DateTime.now()),
                                false)));
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => saleBtnColor)),
                      child: Text(
                        "Продажа",
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        contexts.router.push(OperationRoute(
                            operation: Operation(
                                operations.isNotEmpty
                                    ? operations[operations.length - 1].number +
                                        1
                                    : 1,
                                operations.isNotEmpty
                                    ? operations[operations.length - 1].number +
                                        1
                                    : 1,
                                1,
                                operationsProvider.warehouses[0],
                                operationsProvider.clients[0],
                                "",
                                [],
                                DateFormat("dd.MM.yy HH:mm")
                                    .format(DateTime.now()),
                                false)));
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => moveBtnColor)),
                      child: Text(
                        "Перемещение",
                        style: TextStyle(fontSize: 17, color: Colors.black),
                      )),
                ),
              ],
            ),
          ),
        );
      });
}
