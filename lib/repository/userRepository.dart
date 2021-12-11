import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:skly/controller/userController.dart';
import 'package:skly/model/user.dart' as UserModel;

class UserRepository {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel.User> getUser() async {
    var doc =
        await _firestore.collection('User').doc(_auth.currentUser!.uid).get();
    var joiningCollection = [];
    await _firestore
        .collection('User')
        .doc(_auth.currentUser!.uid)
        .collection('joining')
        .get()
        .then((value) {
      value.docs.forEach((document) {
        joiningCollection.add(document.data()['joiningChat']);
      });
    });
    print("Repository:" + joiningCollection.toString());
    UserModel.User user = UserModel.User(
        id: doc['uid'],
        name: doc['name'],
        email: doc['email'],
        joining: joiningCollection,
        account: doc['account']);
    return user;
  }

  Future<void> setUser() async {
    _firestore
        .collection('User')
        .where('uid', isEqualTo: _auth.currentUser!.uid)
        .get()
        .then((users) {
      if (users.size == 0) {
        _firestore
            .collection('User')
            .doc(_auth.currentUser!.uid)
            .set(<String, dynamic>{
          'email': _auth.currentUser!.email,
          'name': _auth.currentUser!.displayName,
          'uid': _auth.currentUser!.uid,
        });
      }
    });
  }

  Future<void> deletePost({required String postId}) async {
    await _firestore
        .collection('User')
        .doc(_auth.currentUser!.uid)
        .collection('joining')
        .doc(postId)
        .delete();
  }

  Future<void> addJoiningPost({required String postId}) async {
    DocumentReference reference =
        _firestore.collection('User').doc(_auth.currentUser!.uid);
    DocumentReference postReference = _firestore.collection('Post').doc(postId);
    Map<String, dynamic> data = {'joiningChat': postReference};
    await reference.collection('joining').doc(postId).set(data);
  }
}
