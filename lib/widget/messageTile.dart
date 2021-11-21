import 'package:flutter/material.dart';
import 'package:skly/model/message.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageTile extends StatelessWidget {
  MessageTile(this.message);

  final Message message;

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser!.uid == message.uid) {
      return Column(children: [
        SizedBox(
          height: 10,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Container(
            padding: EdgeInsets.all(10),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.50),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Text(
              message.content,
              maxLines: 10,
            ),
          ),
          SizedBox(
            width: 1,
          ),
        ]),
        SizedBox(
          height: 10,
        ),
      ]);
    } else {
      return Column(children: [
        SizedBox(
          height: 15,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(message.photo),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(message.name),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.50),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Text(
                      message.content,
                      maxLines: 10,
                    ),
                  ),
                ],
              )
            ]),
        SizedBox(
          height: 15,
        ),
      ]);
    }
  }
}
