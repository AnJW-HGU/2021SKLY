import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String? id;
  String? userId;
  String? store;
  String? category;
  String? content;
  int? people;
  List<String>? peopleJoin;
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
    this.peopleJoin,
    this.place,
    this.closeTime,
    this.writeTime,
    this.isClose,
  });

  Post copyWith({
    String? id,
    String? userId,
    String? store,
    String? category,
    String? content,
    int? people,
    List<String>? peopleJoin,
    String? place,
    Timestamp? closeTime,
    Timestamp? writeTime,
    bool? isClose,
  }) {
    return Post(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      store: store ?? this.store,
      category: category ?? this.category,
      content: content ?? this.content,
      people: people ?? this.people,
      peopleJoin: peopleJoin ?? this.peopleJoin,
      place: place ?? this.place,
      closeTime: closeTime ?? this.closeTime,
      writeTime: writeTime ?? this.writeTime,
      isClose: isClose ?? this.isClose,
    );
  }

  factory Post.fromDocs(Map<String, dynamic> ds) {
    return Post(
      id: ds['id'],
      userId: ds['userId'],
      store: ds['store'],
      category: ds['category'],
      content: ds['content'],
      people: ds['people'],
      peopleJoin: ds['peopleJoin'].cast<String>(),
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
      peopleJoin: ss.get('peopleJoin').cast<String>(),
      place: ss.get('place'),
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
      'peopleJoin': peopleJoin,
      'place': place,
      'closeTime': closeTime,
      'writeTime': writeTime,
      'isClose': isClose,
    };
  }
}
