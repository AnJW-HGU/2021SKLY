import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home.dart';
import 'main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Future<FirebaseApp> _init =  Firebase.initializeApp();
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
            const SizedBox(height: 180.0),
            Column(
              children: <Widget>[
                Image.asset('assets/diamond.png'),
                const SizedBox(height: 16.0),
                const Text('SHRINE'),
              ],
            ),
            const SizedBox(height: 12.0),
            Consumer<LoginProvider>(
              builder: (context, loginState, _) =>
                  SignInButton(Buttons.Google, onPressed: () async {
                    try {
                      signInWithGoogle().then((value) {
                        FirebaseFirestore.instance
                            .collection('user')
                            .where('uid', isEqualTo: value.user!.uid)
                            .get()
                            .then((users) {
                          if (users.size == 0) {
                            FirebaseFirestore.instance
                                .collection('user')
                                .doc(value.user!.uid)
                                .set(<String, dynamic>{
                              'email': value.user!.email,
                              'name': value.user!.displayName,
                              'status_message':
                              "I promise to take the test honestly before God",
                              'uid': value.user!.uid,
                            });
                          }
                          loginState.googleLogin();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => HomePage()));
                        });
                      });
                    } on FirebaseAuthException catch (e) {
                    }
                  }),
            ),
            Consumer<LoginProvider>(
                builder: (context, loginState, _) => ElevatedButton(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance
                          .signInAnonymously()
                          .then((value) {
                        FirebaseFirestore.instance
                            .collection('user')
                            .doc(value.user!.uid)
                            .set(<String, dynamic>{
                          'status_message':
                          "I promise to take the test honestly before God",
                          'uid': value.user!.uid,
                        });
                        value.user!.updatePhotoURL(
                            'https://firebasestorage.googleapis.com/v0/b/moapp-final-exam-juwon.appspot.com/'
                                'o/profile%2Flogo.png?alt=media&token=b3971d12-10b2-4427-a7f3-7c90fd4d61ed');
                        loginState.anonymousLogin();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      });
                    } on FirebaseAuthException catch (e) {
                    }
                  },
                  child: Text('Guest Login'),
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.grey)),
                ))
          ],
        ),
      ),
    );
  }
}

// TODO: Add AccentColorOverride (103)
