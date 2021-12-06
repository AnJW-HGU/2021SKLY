import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skly/profile/myProfile.dart';
import 'package:skly/controller/chatListController.dart';
import 'package:skly/src/sklyTheme.dart';
import 'package:skly/widget/currentChatTile.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({required this.chatListController});
  final ChatListController chatListController;
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('내가 속한 채팅방')),
        backgroundColor: colorScheme.primary,
      ),
      body: GetBuilder<ChatListController>(
        builder: (chatListController) {
          /* return ListView.builder(
            reverse: true,
            shrinkWrap: true,
            itemCount: chatListController.currentChat.length,
            itemBuilder: (BuildContext context, int index) {
              return chatListController.currentChat[index];
            },
          );*/
          /* setState(() {
            myChattingList = widget.chatListController.currentChat;
          });*/
          return ListView(children: widget.chatListController.currentChat);
        },
      ),
    );
  }
}
