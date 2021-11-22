import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skly/model/post.dart';
import 'package:skly/repository/postRepository.dart';

class PostsController extends GetxController {
  PostsController() {
    init();
  }

  TimeOfDay closeTime = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  String category = "all";
  late Stream<List<Post>> stream;

  Future<void> init() async {
    stream = PostRepository().getAllPosts();
    update();
  }

  Future<void> changeCategory({required String category}) async {
    this.category = category;
    stream = PostRepository().getPosts(category: category);
    update();
  }


}