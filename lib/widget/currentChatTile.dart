import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skly/chat/chatRoom.dart';
import 'package:skly/controller/chatRoomController.dart';

class CurrentChatTile extends StatelessWidget {
  final String? store;
  final String? docId;
  CurrentChatTile(this.store, this.docId);
  ChatRoomController _chatRoomController = Get.put(ChatRoomController());

  @override
  Widget build(BuildContext context) {
    print(docId);
    return ListTile(
        title: Text(store!),
        onTap: () async {
          print(docId);
          _chatRoomController.setCurrentRoomId(docId!);
          print("Tapped:" + _chatRoomController.currentRoomId!);
          await Get.to(ChatRoomPage(
            chatRoomController: _chatRoomController,
            docId: docId,
          ));
        });
  }
}
