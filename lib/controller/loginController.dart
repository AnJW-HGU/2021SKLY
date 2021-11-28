import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skly/controller/userController.dart';
import 'package:skly/repository/userRepository.dart';

enum LoginState {
  loggedOut,
  loggedGoogleIn,
}

class LoginController extends GetxController {
  LoginState loginState = LoginState.loggedOut;


  Future<void> signInWithGoogle() async {
    UserController _userController = Get.find<UserController>();

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    await UserRepository().setUser();
    await _userController.setUser();
    loginState = LoginState.loggedGoogleIn;

    update();
  }

  Future<void> signOutWithGoogle() async {
    FirebaseAuth.instance.signOut();
    loginState = LoginState.loggedOut;
    update();
  }
}