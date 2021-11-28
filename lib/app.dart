import 'package:flutter/material.dart';
import 'package:skly/controller/loginController.dart';
import 'package:skly/controller/userController.dart';
import 'package:skly/home.dart';
import 'package:skly/login/login.dart';
import 'package:get/get.dart';
import 'package:skly/src/sklyTheme.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  LoginController _loginController = Get.put(LoginController());
  UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SKLY',
      theme: SKLYTheme.lightThemeData,
      home: GetBuilder<LoginController>(
        builder: (_) {
          if (_loginController.loginState == LoginState.loggedOut) {
            return LoginPage();
          }
          else {
            return HomePage();
          }
        },
      ),
    );
  }
}
