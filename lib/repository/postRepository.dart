import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skly/model/post.dart';

class PostRepository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> setPost(Post post) async {
    String pid = _firestore.collection('Post').doc().id;
    post = post.copyWith(id: pid);
    DocumentReference reference = _firestore.collection('Post').doc(post.id);
    await reference.set(post.toMap());
  }

  Future<void> deletePost({required String postId}) async {
    await _firestore.collection('Post').doc(postId).delete();
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
