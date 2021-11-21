import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skly/controller/chatRoomController.dart';
import 'package:get/get.dart';
import 'package:skly/widget/messageTile.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({Key? key}) : super(key: key);

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

/**
 * 우선 해야할 것은 Stream builder을 사용해서 메시지의 정보를 가져오는 것이다. 
 * 그것만 하면 이제 일사천리로 할 수 있을 것 같다. 
 * 메뉴도 구현해야하는데, 참가자 목록의 경우...아니 그냥 getx를 사용해보자.
 * 
 * 
 */

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('TestChatRoom')),
        backgroundColor: colorScheme.primary,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        GetBuilder<ChatRoomController>(
            init: ChatRoomController(),
            builder: (_) {
              return Expanded(
                child: ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  itemCount: _.messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return MessageTile(_.messages[index]);
                  },
                ),
              );
            }),
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
                      print('CurrentTime:' +
                          FieldValue.serverTimestamp().toString());
                      await FirebaseFirestore.instance
                          .collection('TestChatRoom')
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
