import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skly/chat/chatRoom.dart';
import 'package:skly/controller/chatRoomController.dart';
import 'package:skly/model/user.dart' as UserModel;
import 'package:clipboard/clipboard.dart';
import 'package:fluttertoast/fluttertoast.dart';

class chatPageUserTile extends StatelessWidget {
  final UserModel.User user;
  final String admin;
  chatPageUserTile({required this.user, required this.admin});

  @override
  Widget build(BuildContext context) {
    if (user.id == admin) {
      return ListTile(
          title: Text(user.name! + '(방장)'),
          onLongPress: () async {
            await FirebaseFirestore.instance
                .collection('User')
                .doc(user.id)
                .get()
                .then((value) {
              String account;
              account = value.data()!['account'];
              FlutterClipboard.copy(account);
              Fluttertoast.showToast(
                  msg: "클립보드에 복사됨",
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey,
                  textColor: Colors.white,
                  fontSize: 16.0);
            });
          });
    } else {
      return ListTile(title: Text(user.name!));
    }
  }
}
