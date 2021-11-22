import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skly/model/post.dart';

class PostRepository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> setPost(Post post) async {
    await _firestore.collection('Post').add(post.toMap());
  }

  Stream<List<Post>> getAllPosts() {
    final snapshot = _firestore.collection('Post').orderBy('closeTime').snapshots();
    return snapshot.map((snapshot) {
      List<Post> result = [];
      try {
        result = snapshot.docs.map((e) => Post.fromDocs(e.data())).toList();
      } catch (e) {
        print(e);
      }
      return result;
    });
  }

  Stream<List<Post>> getPosts({required String category}) {
    final snapshot = _firestore
        .collection('Post')
        .where('category', isEqualTo: category)
        .orderBy('closeTime')
        .snapshots();
    return snapshot.map((snapshot) {
      List<Post> result = [];
      try {
        result = snapshot.docs.map((e) => Post.fromDocs(e.data())).toList();
      } catch (e) {
        print(e);
      }
      return result;
    });
  }
}
