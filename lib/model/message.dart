import 'package:cloud_firestore/cloud_firestore.dart';

enum messageType { text, photo }

class Message {
  final String content;
  final Timestamp? sentTime;
  final String name;
  final String uid;
  final String type;
  final String photo;

  Message(
      {required this.content,
      required this.sentTime,
      required this.name,
      required this.uid,
      required this.type,
      required this.photo});
}
