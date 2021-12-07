import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skly/controller/loginController.dart';
import 'package:skly/controller/userController.dart';

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  bool isEditing = false;
  bool accountEditing = false;
  TextEditingController? _controller = TextEditingController(
      text: FirebaseAuth.instance.currentUser!.displayName);
  UserController userController = Get.put(UserController());
  Widget myName = Text(
    '${FirebaseAuth.instance.currentUser!.displayName}',
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  );

  LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "프로필",
          style: TextStyle(fontSize: 15, color: colorScheme.surface),
        ),
        backgroundColor: colorScheme.primary,
        actions: [
          IconButton(
              onPressed: () {
                _loginController.signOutWithGoogle();
              },
              icon: Icon(
                Icons.exit_to_app,
                color: colorScheme.surface,
              ))
        ],
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 1.0,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.network(
                    FirebaseAuth.instance.currentUser!.photoURL!)),
            Container(
              padding: EdgeInsets.all(30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isEditing == false
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                    myName,
                                    ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            isEditing = true;
                                          });
                                        },
                                        child: Text('Change display name'))
                                  ])
                            : Column(
                                children: [
                                  TextField(
                                    controller: _controller,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                          onPressed: () async {
                                            setState(() {
                                              isEditing = false;
                                            });
                                          },
                                          child: Text('Cancel')),
                                      ElevatedButton(
                                          onPressed: () async {
                                            _controller = TextEditingController(
                                                text: _controller?.text);
                                            FirebaseAuth.instance.currentUser!
                                                .updateDisplayName(
                                                    _controller!.text);
                                            setState(() {
                                              myName = Text(
                                                '${_controller!.text}',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              );
                                              isEditing = false;
                                              print(_controller?.text);
                                            });
                                          },
                                          child: Text('Save'))
                                    ],
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        GetBuilder<UserController>(builder: (_) {
                          String? account = userController.user.account;
                          TextEditingController? _accountController =
                              TextEditingController(
                                  text: userController.user.account);
                          return accountEditing == false
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                      Text(account!),
                                      ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              accountEditing = true;
                                            });
                                          },
                                          child: Text('Account Change'))
                                    ])
                              : Column(
                                  children: [
                                    TextField(
                                      controller: _accountController,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                            onPressed: () async {
                                              setState(() {
                                                accountEditing = false;
                                              });
                                            },
                                            child: Text('Cancel')),
                                        ElevatedButton(
                                            onPressed: () async {
                                              var result =
                                                  _accountController!.text;
                                              _accountController =
                                                  TextEditingController(
                                                text: _accountController?.text,
                                              );
                                              setState(() {
                                                accountEditing = false;
                                                print(_accountController?.text);
                                              });
                                              userController.updateAccount(
                                                  _accountController!.text);
                                            },
                                            child: Text('Save'))
                                      ],
                                    ),
                                  ],
                                );
                        }),
                        SizedBox(
                          height: 8,
                        ),
                        /* Text(
                  snapshot.data!['email'].toString(),
                  style: TextStyle(fontSize: 20),
                ),*/
                      ],
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
    /*return */
  }
}
