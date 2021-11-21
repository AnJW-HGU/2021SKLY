import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skly/model/user.dart' as UserModel;

class UserRepository {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel.User> getUser() async {
    var doc =
        await _firestore.collection('User').doc(_auth.currentUser!.uid).get();
    UserModel.User user = UserModel.User(
        id: doc['uid'],
        name: doc['name'],
        email: doc['email'],
        joiningChat: doc['joiningChat']?.cast<String>());
    return user;
  }

  Future<void> setUser() async {
    FirebaseFirestore.instance
        .collection('User')
        .where('uid', isEqualTo: _auth.currentUser!.uid)
        .get()
        .then((users) {
      if (users.size == 0) {
        FirebaseFirestore.instance
            .collection('User')
            .doc(_auth.currentUser!.uid)
            .set(<String, dynamic>{
          'email': _auth.currentUser!.email,
          'name': _auth.currentUser!.displayName,
          'uid': _auth.currentUser!.uid,
          'joiningChat': []
        });
      }
    });
  }
}