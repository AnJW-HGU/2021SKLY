import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skly/repository/userRepository.dart';

enum LoginState {
  loggedOut,
  loggedGoogleIn,
}

class LoginController extends GetxController {
  LoginState loginState = LoginState.loggedOut;

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    loginState = LoginState.loggedGoogleIn;
    await FirebaseAuth.instance.signInWithCredential(credential);
    UserRepository().setUser();
    update();
  }

  Future<void> signOutWithGoogle() async {
    FirebaseAuth.instance.signOut();
    loginState = LoginState.loggedOut;
    update();
  }
}