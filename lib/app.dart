import 'package:flutter/material.dart';
import 'package:skly/home.dart';
import 'package:skly/login/login.dart';
import 'package:get/get.dart';
import 'package:skly/src/sklyTheme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SKLY',
      theme: SKLYTheme.lightThemeData,
      home: HomePage(),
    );
  }
}
