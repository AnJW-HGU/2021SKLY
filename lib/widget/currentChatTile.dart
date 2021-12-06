import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skly/chat/chatRoom.dart';
import 'package:skly/controller/chatRoomController.dart';
import 'package:skly/model/post.dart';

class CurrentChatTile extends StatelessWidget {
  final Post? post;
  final int index;
  CurrentChatTile({required this.post, required this.index});

  @override
  Widget build(BuildContext context) {
    ChatRoomController _chatRoomController = Get.put(ChatRoomController(post));
    return ListTile(
        title: Text(post!.store!),
        onTap: () async {
          _chatRoomController.setCurrentRoomId(post!.id!);
          await Get.to(ChatRoomPage(
              chatRoomController: _chatRoomController,
              docId: post!.id!,
              index: index,
              post: post));
        });
  }
}
