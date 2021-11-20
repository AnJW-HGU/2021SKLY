import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import '../chat/chatList.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Future<FirebaseApp> _init = Firebase.initializeApp();
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = await GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 12.0),
            SignInButton(Buttons.Google, onPressed: () async {
              try {
                signInWithGoogle().then((value) {
                  FirebaseFirestore.instance
                      .collection('User')
                      .where('uid', isEqualTo: value.user!.uid)
                      .get()
                      .then((users) {
                    if (users.size == 0) {
                      FirebaseFirestore.instance
                          .collection('User')
                          .doc(value.user!.uid)
                          .set(<String, dynamic>{
                        'email': value.user!.email,
                        'name': value.user!.displayName,
                        'uid': value.user!.uid,
                        'joiningChat': []
                      });
                    }
                  });
                });
                Get.to(() => ChatList());
              } on FirebaseAuthException catch (e) {}
            }),
          ],
        ),
      ),
    );
  }
}

// TODO: Add AccentColorOverride (103)
