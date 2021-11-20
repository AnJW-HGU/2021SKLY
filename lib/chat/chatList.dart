import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skly/login/login.dart';
import 'package:skly/profile/myProfile.dart';

class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      ElevatedButton(
          onPressed: () {
            Get.to(() => Profile());
          },
          child: Text('Go to Profile!'))
      /*GetBuilder<Controller>(builder: (_) {
        return Column(
          children: [
            Text('${_.count}'),
            ElevatedButton(
                onPressed: () {
                  _.increment();
                },
                child: Text('Increase!'))
          ],
        );
      }),*/
    ]));
  }
}
