import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skly/model/message.dart';
import 'package:skly/model/post.dart';
import 'package:skly/model/user.dart' as UserModel;
import 'package:skly/widget/chatPageUserTile.dart';

class ChatRoomController extends GetxController {
  List<Message> messages = [];
  List<dynamic> usersString = [];
  List<UserModel.User> users = [];
  List<chatPageUserTile> tiles = [];
  String? currentRoomId;
  Post? post;
  String? admin;
  int? joinedPersonNum;

  getTiles() {
    return tiles;
  }

  ChatRoomController(Post? currentPost) {
    post = currentPost;
    // init();
    update();
  }

  setCurrentRoomId(String id) {
    currentRoomId = id;
    init();
    update();
  }

  getjoiningList() async {
    return usersString;
  }

  getMessages() {
    return messages;
  }

  init() async {
    FirebaseFirestore.instance
        .collection('Post')
        .doc(currentRoomId)
        .snapshots()
        .listen((event) async {
      usersString.clear();
      usersString = await event.data()!['peopleJoin'].cast<List<String>>();
      String admin = await event.data()!['userId'];
      joinedPersonNum = usersString.length;
      tiles.clear();
      FirebaseFirestore.instance
          .collection('User')
          .where('uid', whereIn: usersString)
          .get()
          .then((value) async {
        value.docs.forEach((element) async {
          UserModel.User user = UserModel.User(
              name: await element.data()['name'], id: element.data()['uid']);
          users.add(user);
          tiles.add(chatPageUserTile(user: user, admin: admin));
        });
        users.forEach((element) {});
        update();
      });
      update();
    });
    //.snapshots()
    /*.listen((event) {
      users.clear();
      event.docs.forEach((element) {
        users.add(UserModel.User(name: element.get('name')));
        update();
      });
    });*/
    FirebaseFirestore.instance
        .collection('Post')
        .doc(currentRoomId)
        .snapshots()
        .listen((event) {
      admin = event.data()!['userId'];
    });
    FirebaseFirestore.instance
        .collection('Post')
        .doc(currentRoomId)
        .collection('message')
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
