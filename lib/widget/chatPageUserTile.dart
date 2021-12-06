import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skly/chat/chatRoom.dart';
import 'package:skly/controller/chatRoomController.dart';
import 'package:skly/model/user.dart' as UserModel;

class chatPageUserTile extends StatelessWidget {
  final UserModel.User user;
  final String admin;
  chatPageUserTile({required this.user, required this.admin});

  @override
  Widget build(BuildContext context) {
    if (user.id == admin) {
      return ListTile(title: Text(user.name! + '(방장)'));
    } else {
      return ListTile(title: Text(user.name!));
    }
  }
}
