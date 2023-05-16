import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:venons_automark/constants/colors.dart';
import 'package:venons_automark/models/Item/Item.dart';
import 'package:venons_automark/models/Operation/Operation.dart';
import 'package:venons_automark/models/Operations/Operations.dart';
import 'package:venons_automark/models/User/User.dart';
import 'package:venons_automark/providers/AuthProvider.dart';
import 'package:venons_automark/routes/router.dart';

import 'providers/OperationsProvider.dart';
import 'screens/connect_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: "lib/.env");
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());

  await Hive.openBox<User>('users');

  final AuthProvider authProvider = AuthProvider();
  final OperationsProvider operationsProvider = OperationsProvider();
  authProvider.getUserFromDb();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => authProvider),
    ChangeNotifierProvider(create: (_) => operationsProvider),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
        GlobalKey<ScaffoldMessengerState>();
    return MaterialApp(
      title: 'Venons Automark',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue, scaffoldBackgroundColor: Colors.white),
      home: AnimatedSplashScreen(
          splash: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: SizedBox(
                width: 150,
                height: 150,
                child: Image.asset(
                  'assets/logo.jpg',
                  width: 150,
                  height: 150,
                ),
              )),
          backgroundColor: Colors.white,
          duration: 3000,
          nextScreen: MaterialApp.router(
            title: 'Venons Automark',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.blue,
                scaffoldBackgroundColor: Colors.white),
            scaffoldMessengerKey: scaffoldMessengerKey,
            routerDelegate: _appRouter.delegate(),
            routeInformationParser: _appRouter.defaultRouteParser(),
          )),
    );
  }
}
