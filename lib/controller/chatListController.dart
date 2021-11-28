import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skly/widget/currentChatTile.dart';
import 'package:skly/repository/userRepository.dart';
import 'package:skly/model/user.dart' as UserModel;

class ChatListController extends GetxController {
  List<CurrentChatTile> currentChat = [];
  UserModel.User? curUser;
  ChatListController() {
    init();
  }

  init() async {
    await Firebase.initializeApp();
    currentChat.clear();
    FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('joining')
        .snapshots()
        .listen((sanpshot) {
      print('Change Detected');
      currentChat.clear();
      sanpshot.docs.forEach((document) {
        DocumentReference current = document.get('joiningChat');
        current.get().then((value) {
          print(document.id);
          currentChat.add(CurrentChatTile(value.get('store'), document.id));
        });
      });
      update();
    });
    update();
  }
}
