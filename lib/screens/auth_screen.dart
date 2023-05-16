import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:venons_automark/constants/colors.dart';
import 'package:venons_automark/providers/AuthProvider.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String title = '';
  String password = '';
  bool _isObsured = true;

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Image.asset(
                      'assets/logo.jpg',
                      height: 180,
                    ),
                  ),
                  Text(
                    'VENONS - AUTOMARK',
                    style: TextStyle(
                        color: logoTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Text(
              'Войти',
              style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              child: TextFormField(
                keyboardType: TextInputType.text,
                key: const ValueKey('title'),
                onChanged: (e) {
                  setState(() {
                    title = e;
                  });
                },
                cursorColor: saleBtnColor,
                decoration: InputDecoration(
                    labelText: 'Логин',
                    focusColor: saleBtnColor,
                    labelStyle: const TextStyle(
                        color: saleBtnColor, fontWeight: FontWeight.bold),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: logoTextColor),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              child: TextField(
                keyboardType: TextInputType.text,
                key: const ValueKey('password'),
                onChanged: (text) => {
                  setState(() {
                    password = text;
                  })
                },
                cursorColor: saleBtnColor,
                obscureText: _isObsured,
                decoration: InputDecoration(
                    focusColor: logoTextColor,
                    labelStyle: const TextStyle(
                        color: saleBtnColor, fontWeight: FontWeight.bold),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: logoTextColor),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10.0),
                    suffixIconColor: logoTextColor,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObsured ? Icons.visibility : Icons.visibility_off,
                        color: logoTextColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObsured = !_isObsured;
                        });
                      },
                    ),
                    labelText: 'Пароль',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () async {},
              child: false
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GestureDetector(
                      onTap: () {
                        if (title.isNotEmpty && password.isNotEmpty) {
                          authProvider.login(title, password);
                        } else {
                          final snackBar = SnackBar(
                            content: const Text('Заполните все поля!'),
                            action: SnackBarAction(
                              label: 'ОК',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Container(
                          key: const ValueKey('signIn'),
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                              color: saleBtnColor,
                              borderRadius: BorderRadius.circular(6)),
                          child: Center(
                            child: Text(
                              "Войти",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          )),
                    ),
            ),
          ],
        ),
      )),
    );
  }
}
