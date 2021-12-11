import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skly/model/post.dart';
import 'package:skly/repository/postRepository.dart';
import 'package:skly/repository/userRepository.dart';

class PostsController extends GetxController {
  PostsController() {
    init();
  }

  TimeOfDay closeTime =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  String category = "전체";
  late Stream<List<Post>> stream;

  Future<void> init() async {
    stream = PostRepository().getAllPosts();
    update();
  }

  Future<void> changeCategory({required String category}) async {
    this.category = category;
    if (category == "전체") {
      stream = PostRepository().getAllPosts();
    } else {
      stream = PostRepository().getPosts(category: category);
    }
    update();
  }

  void deletePost({required String postId}) {
    Get.defaultDialog(
        title: '모집글 삭제',
        content: Text('해당 글을 삭제 하시겠습니까?'),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('취소')),
          TextButton(
              onPressed: () {
                PostRepository().deletePost(postId: postId);
                UserRepository().deletePost(postId: postId);
                Get.back();
              },
              child: Text('삭제')),
        ]);
  }

  void joinPost({required String postId, required String userId}) {
    PostRepository().joinPost(postId: postId, userId: userId);
    UserRepository().addJoiningPost(postId: postId);
  }
}
