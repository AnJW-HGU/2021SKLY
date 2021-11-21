import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skly/model/post.dart';

class PostRepository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> setPost(Post post) async {
    _firestore.collection('Post').doc(post.id).set(post.toMap());
  }
}
