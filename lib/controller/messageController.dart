import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skly/model/message.dart';

class GetMessage extends GetxController {
  List<Message> messages = [];
  GetMessage() {
    init();
  }
  init() async {
    FirebaseFirestore.instance
        .collection('TestChatRoom')
        .snapshots()
        .listen((snapshot) {
      messages.clear();
      snapshot.docs.forEach((document) {
        messages.add(Message(
            content: document.data()['content'],
            name: document.data()['name'],
            sentTime: document.data()['sentTime'],
            type: document.data()['type'],
            uid: document.data()['uid']));
      });
      update();
    });
  }
}
