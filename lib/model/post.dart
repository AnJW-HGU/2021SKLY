import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String? id;
  String? userId;
  String? store;
  String? content;
  int? people;
  Timestamp? writeTime;
  bool? isClose;

  Post({
    this.id,
    this.userId,
    this.store,
    this.content,
    this.people,
    this.writeTime,
    this.isClose,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'store': store,
      'content': content,
      'people': people,
      'writeTime': writeTime,
      'isClose': isClose,
    };
  }
}