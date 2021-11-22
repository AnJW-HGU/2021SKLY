import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skly/controller/postsController.dart';
import 'package:skly/model/post.dart';
import 'package:intl/intl.dart';
import 'package:skly/post/addPost.dart';
import 'package:skly/repository/postRepository.dart';

class BoardPage extends StatelessWidget {
  BoardPage({Key? key}) : super(key: key);

  PostsController _postsController = Get.put(PostsController());

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              '시킬래요?',
              style: TextStyle(
                fontSize: 15,
                color: colorScheme.surface,
              ),
            ),
            pinned: true,
            floating: true,
            expandedHeight: 200.0,
            flexibleSpace: Placeholder(),
            backgroundColor: colorScheme.primary,
            // bottom: ListView(
            //   scrollDirection: Axis.horizontal,
            //   children: [
            //     _buildCategory(context, '치킨'),
            //     _buildCategory(context, '밥'),
            //   ],
            // ),
          ),
          StreamBuilder<List<Post>>(
              stream: _postsController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Column(
                        children: [
                          (snapshot.data![index].isClose ?? false)
                              ? _buildClosePost(context, snapshot.data![index])
                              : _buildPost(context, snapshot.data![index]),
                          Divider(
                              height: 1,
                              thickness: 1,
                              indent: 10,
                              endIndent: 10,
                              color: colorScheme.primaryVariant),
                        ],
                      );
                    }, childCount: snapshot.data!.length),
                  );
                } else if (!snapshot.hasData) {
                  return SliverToBoxAdapter(child: LinearProgressIndicator());
                } else {
                  print('error');
                  return SliverToBoxAdapter(child: Container());
                }
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddPostPage());
        },
        child: Icon(
          Icons.add_rounded,
          color: Colors.black,
        ),
        backgroundColor: colorScheme.secondary,
      ),
    );
  }

  Widget _buildCategory(BuildContext context, String category) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: colorScheme.surface,
        ),
        Text('$category', style: TextStyle(fontSize: 14, color: colorScheme.surface),),
      ],
    );
  }

  Widget _buildPost(BuildContext context, Post post) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        print('dialog 띄우기');
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text("[${post.store}]"),
              //     Text("${post.place}"),
              //   ],
              // ),
              Text('[${post.store}]'),
              Text('${post.place}'),
              SizedBox(
                height: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${post.content}',
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Text(
                      '${DateFormat('MM.dd kk:mm').format((post.closeTime)!.toDate())}'),
                  SizedBox(
                    width: 10,
                  ),
                  if (post.people == 100) Text('없음'),
                  if (post.people != 100) Text('0/${post.people}'),
                  // 참여자 수 받기 (수정)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClosePost(BuildContext context, Post post) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        print('dialog 띄우기');
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("[${post.store}]",
                          style: TextStyle(color: colorScheme.primaryVariant)),
                      Text("${post.place}",
                          style: TextStyle(color: colorScheme.primaryVariant)),
                    ],
                  ),
                  Icon(Icons.check_circle, color: colorScheme.primaryVariant),
                ],
              ),
              SizedBox(
                height: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${post.content}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: colorScheme.primaryVariant),
                  ),
                  Spacer(),
                  Text(
                    '${DateFormat('MM.dd kk:mm').format((post.closeTime)!.toDate())}',
                    style: TextStyle(color: colorScheme.primaryVariant),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  if (post.people == 100)
                    Text(
                      '없음',
                      style: TextStyle(color: colorScheme.primaryVariant),
                    ),
                  if (post.people != 100)
                    Text(
                      '0/${post.people}',
                      style: TextStyle(color: colorScheme.primaryVariant),
                    ),
                  // 참여자 수 받기 (수정)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
