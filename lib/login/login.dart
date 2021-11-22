import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import 'package:skly/controller/loginController.dart';
import 'package:skly/controller/userController.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  LoginController _loginController = Get.put(LoginController());
  UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        children: <Widget>[
          SizedBox(height: 150.0),
          Center(child: Text('시킬래요?', style: TextStyle(fontSize: 25, color: Colors.white),)),
          SizedBox(height: 200.0),
          SignInButton(Buttons.Google, onPressed: () async {
            await _loginController.signInWithGoogle();
            _userController.setUser();
          }),
        ],
      ),
    );
  }
}
