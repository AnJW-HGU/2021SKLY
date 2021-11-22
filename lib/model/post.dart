import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String? id;
  String? userId;
  String? store;
  String? category;
  String? content;
  int? people;
  String? place;
  Timestamp? closeTime;
  Timestamp? writeTime;
  bool? isClose;

  Post({
    this.id,
    this.userId,
    this.store,
    this.category,
    this.content,
    this.people,
    this.place,
    this.closeTime,
    this.writeTime,
    this.isClose,
  });

  factory Post.fromDocs(Map<String, dynamic> ds) {
    return Post(
      id: ds['id'],
      userId: ds['userId'],
      store: ds['store'],
      category: ds['category'],
      content: ds['content'],
      people: ds['people'],
      place: ds['place'],
      closeTime: ds['closeTime'],
      writeTime: ds['writeTime'],
      isClose: ds['isClose'],
    );
  }

  factory Post.fromSnapshot(DocumentSnapshot ss) {
    return Post(
      id: ss.get('id'),
      userId: ss.get('userId'),
      store: ss.get('store'),
      category: ss.get('category'),
      content: ss.get('content'),
      people: ss.get('people'),
      place: ss.get('people'),
      closeTime: ss.get('closeTime'),
      writeTime: ss.get('writeTime'),
      isClose: ss.get('isClose'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'store': store,
      'category': category,
      'content': content,
      'people': people,
      'place': place,
      'closeTime': closeTime,
      'writeTime': writeTime,
      'isClose': isClose,
    };
  }
}