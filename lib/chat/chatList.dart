import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skly/profile/myProfile.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({Key? key}) : super(key: key);

  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      ElevatedButton(
          onPressed: () {
            Get.to(() => MyProfilePage());
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
