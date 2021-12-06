import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skly/model/post.dart';
import 'package:skly/widget/currentChatTile.dart';
import 'package:skly/repository/userRepository.dart';
import 'package:skly/model/user.dart' as UserModel;

class ChatListController extends GetxController {
  List<CurrentChatTile> currentChat = [];
  Post? currentPost;
  UserModel.User? curUser;
  //final snapshot = FirebaseFirestore.instance.collection('Post').orderBy('closeTime', descending: true).snapshots();

  ChatListController() {
    init();
  }

  setTile(int index) {
    currentChat.removeAt(index);
    update();
  }

  init() async {
    await Firebase.initializeApp();
    FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('joining')
        .snapshots()
        .listen((sanpshot) async {
      print('Remove event Starting');
      currentChat.clear();
      int index = 0;
      sanpshot.docs.forEach((document) async {
        DocumentReference current = await document.get('joiningChat');
        current.get().then((value) async {
          List<dynamic> peopleJoin = await value.get('peopleJoin');
          List<String> peopleJoinStr = peopleJoin.cast<String>();
          currentPost = Post(
              store: await value.get('store'),
              id: await value.get('id'),
              userId: await value.get('userId'),
              peopleJoin: peopleJoinStr);
          currentChat.add(CurrentChatTile(post: currentPost, index: index));
          index += 1;
        });
      });
      update();
    });
    update();
  }
}
