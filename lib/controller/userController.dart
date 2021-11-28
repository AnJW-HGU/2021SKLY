import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:skly/model/user.dart' as UserModel;
import 'package:skly/repository/userRepository.dart';

class UserController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late UserModel.User user;

  Future<void> setUser() async {
    user = await UserRepository().getUser();
    update();
  }
}