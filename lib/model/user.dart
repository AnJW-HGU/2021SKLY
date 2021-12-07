import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? id;
  String? name;
  String? email;
  List<dynamic>? joining;
  String? account;

  User({this.id, this.name, this.email, this.joining, this.account});
}
