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
  const ChatListPage({Key? key}) : super(key: key);

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('TestChatRoom')),
        backgroundColor: colorScheme.primary,
      ),
      body: GetBuilder<ChatListController>(
        init: ChatListController(),
        builder: (_) {
          return ListView(children: _.currentChat);
        },
      ),
    );
  }
}
