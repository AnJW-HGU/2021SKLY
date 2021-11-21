import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skly/model/message.dart';

class ChatRoomController extends GetxController {
  List<Message> messages = [];
  String? currentRoomId;
  ChatRoomController() {
    init();
  }

  setCurrentRoodId(String id) {
    currentRoomId = id;
    update();
  }

  init() async {
    await Firebase.initializeApp();
    FirebaseFirestore.instance
        .collection('TestChatRoom')
        .orderBy('sendTime', descending: true)
        .snapshots()
        .listen((snapshot) {
      messages.clear();
      snapshot.docs.forEach((document) async {
        messages.add(Message(
            content: document.data()['content'],
            name: document.data()['name'],
            sentTime: document.data()['sendTime'],
            type: document.data()['type'],
            uid: document.data()['uid'],
            photo: document.data()['photo']));
      });
      update();
    });
  }
}
