import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetChatRoom extends GetxController {
  int count = 0;
  increment() {
    count++;
    update();
  }
}
