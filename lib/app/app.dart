import 'package:flutter/material.dart';
import 'package:testingdemo/screens/test.dart';
import 'package:testingdemo/services/login_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TestScreen(
        loginService: LoginService(),
      ),
    );
  }
}
