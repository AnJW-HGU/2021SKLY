import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skly/chat/chatList.dart';
import 'package:skly/controller/chatRoomController.dart';
import 'package:get/get.dart';
import 'package:skly/home.dart';
import 'package:skly/widget/messageTile.dart';
import 'package:skly/model/message.dart';
import './googlemapTest.dart';
import 'package:skly/widget/chatPageUserTile.dart';
import 'package:skly/model/post.dart';
import 'package:skly/controller/chatListController.dart';

class ChatRoomPage extends StatefulWidget {
  String? docId;
  final ChatRoomController chatRoomController;
  final Post? post;
  final int index;
  ChatRoomPage(
      {required this.docId,
      required this.chatRoomController,
      required this.post,
      required this.index});

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  ChatListController _chatListController = Get.put(ChatListController());
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  List<MessageTile> messages = [];

  Widget joiningUsers() {
    List<Widget> chatUsers = [];
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Post')
            .doc(widget.chatRoomController.post!.id)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          snapshot.data!['peopleJoin'].forEach((value) async {
            FirebaseFirestore.instance
                .collection('User')
                .doc(value)
                .get()
                .then((name) {
              chatUsers.add(Text(value!));
            });
          });

          return ListView(
            children: chatUsers,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
          title: Center(child: Text(widget.post!.store!)),
          backgroundColor: colorScheme.primary,
          iconTheme: IconThemeData(color: colorScheme.onPrimary)),
      endDrawer: GetBuilder<ChatRoomController>(
        builder: (ChatRoomController) {
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
          return Drawer(
              child: Column(
            children: [
              Expanded(
                  child: ListView(children: widget.chatRoomController.tiles)),
              IconButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('User')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('joining')
                        .doc(widget.docId)
                        .delete();
                    List<String>? peopleJoin = widget.post!.peopleJoin;
                    peopleJoin!.remove(FirebaseAuth.instance.currentUser!.uid);
                    await FirebaseFirestore.instance
                        .collection('Post')
                        .doc(widget.docId)
                        .update({'peopleJoin': peopleJoin});
                    //_chatListController.setTile(widget.index);
                    Get.offAll(HomePage());
                  },
                  icon: Icon(
                    Icons.exit_to_app_outlined,
                    color: colorScheme.onBackground,
                  ))
            ],
          ));
        },
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: GetBuilder<ChatRoomController>(builder: (_) {
            return ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemCount: widget.chatRoomController.messages.length,
              itemBuilder: (BuildContext context, int index) {
                List<Message> curMessage =
                    widget.chatRoomController.getMessages();
                return MessageTile(curMessage[index]);
              },
            );
          }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: TextFormField(
                      minLines: 1,
                      maxLines: 3,
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Leave a message',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your message to continue';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      widget.chatRoomController.setCurrentRoomId(widget.docId!);
                      await FirebaseFirestore.instance
                          .collection('Post')
                          .doc(widget.chatRoomController.currentRoomId)
                          .collection('message')
                          .add({
                        'content': _controller.text,
                        'name': FirebaseAuth.instance.currentUser!.displayName,
                        'sendTime': FieldValue.serverTimestamp(),
                        'type': 'message',
                        'uid': FirebaseAuth.instance.currentUser!.uid,
                        'photo': FirebaseAuth.instance.currentUser!.photoURL
                      });
                      _controller.clear();
                    }
                  },
                  child: Row(
                    children: [
                      Icon(Icons.send),
                      SizedBox(width: 4),
                      Text('SEND'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),

        /*for (var message in widget.messages)
          Row(children: [
            Expanded(
              child: Paragraph('${message.name}: ${message.message}\n '
                  '${DateFormat('yyyy-MM-dd-kk:mm').format(DateTime.fromMillisecondsSinceEpoch(message.time))}'),
            ),
            message.name == FirebaseAuth.instance.currentUser!.displayName
                ? IconButton(
                    onPressed: () async {
                      await widget.removeMessage(message);
                    },
                    icon: Icon(Icons.delete_outline))
                : Container(),
          ]),*/
        SizedBox(
          height: 8,
        ),
      ]),
    );
  }
}
