import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? id;
  String? name;
  String? email;
  List<dynamic>? joining;

  User({
    this.id,
    this.name,
    this.email,
    this.joining,
  });
}
