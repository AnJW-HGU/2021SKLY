import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String? id;
  String? userId;
  String? store;
  String? category;
  String? content;
  int? people;
  String? place;
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
      writeTime: ds['writeTime'],
      isClose: ds['isClose'],
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
      'writeTime': writeTime,
      'isClose': isClose,
    };
  }
}