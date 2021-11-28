import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skly/controller/postsController.dart';
import 'package:skly/model/post.dart';
import 'package:intl/intl.dart';
import 'package:skly/post/addPost.dart';
import 'package:skly/controller/userController.dart';

class BoardPage extends StatelessWidget {
  BoardPage({Key? key}) : super(key: key);

  PostsController _postsController = Get.put(PostsController());
  UserController _userController = Get.find<UserController>();

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
            snap: true,
            expandedHeight: 220.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: EdgeInsets.only(top: 85, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildCategory(context, '치킨'),
                        _buildCategory(context, '치킨'),
                        _buildCategory(context, '치킨'),
                        _buildCategory(context, '치킨'),
                        _buildCategory(context, '치킨'),
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildCategory(context, '치킨'),
                        _buildCategory(context, '치킨'),
                        _buildCategory(context, '치킨'),
                        _buildCategory(context, '치킨'),
                        _buildCategory(context, '치킨'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // flexibleSpace: Padding(
            //   padding: EdgeInsets.only(top: 80),
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     itemCount: 5,
            //     itemBuilder: (BuildContext context, int index) {
            //       return _buildCategory(context, '치킨');
            //     },
            //   ),
            // ),
            backgroundColor: colorScheme.primary,
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
    return GestureDetector(
      onTap: () {
        print('a');
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: colorScheme.surface,
            ),
            Text(
              '$category',
              style: TextStyle(fontSize: 14, color: colorScheme.surface),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPost(BuildContext context, Post post) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        print('dialog 띄우기');
        _postDialog(context, post);
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
                      Text(
                        "[${post.store}]",
                      ),
                      Text(
                        "${post.place}",
                      ),
                    ],
                  ),
                  Visibility(
                      visible: post.userId == _userController.user.id,
                      child: GestureDetector(
                        onTap: () {
                          _postsController.deletePost(postId: post.id!);
                        },
                        child: Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.black,
                        ),
                      )),
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
                  ),
                  Spacer(),
                  Text(
                      '${DateFormat('MM.dd kk:mm').format((post.closeTime)!.toDate())}'),
                  SizedBox(
                    width: 10,
                  ),
                  // if (post.people == 100) Text('없음'),
                  // if (post.people != 100)
                  Text('${post.peopleJoin!.length}/${post.people}'),
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
        // print('dialog 띄우기');
        // _postDialog(context, post);
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
                  // if (post.people == 100)
                  //   Text(
                  //     '없음',
                  //     style: TextStyle(color: colorScheme.primaryVariant),
                  //   ),
                  Text(
                    '${post.peopleJoin!.length}/${post.people}',
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

  Future<dynamic> _postDialog(BuildContext context, Post post) {
    final colorScheme = Theme.of(context).colorScheme;
    return Get.defaultDialog(
        title: '[${post.store!}]',
        content: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('${post.place!}'),
              SizedBox(
                height: 10,
              ),
              Text('${post.content!}'),
              Text(
                '주문 시간: ${DateFormat('MM.dd kk:mm').format((post.closeTime)!.toDate())}',
                // style: TextStyle(color: colorScheme.primaryVariant),
              ),
              // if (post.people == 100)
              //   Text(
              //     '없음',
              //     // style: TextStyle(color: colorScheme.primaryVariant),
              //   ),
              // if (post.people != 100)
              Text(
                '${post.peopleJoin!.length}/${post.people}',
                // style: TextStyle(color: colorScheme.primaryVariant),
              ),
              SizedBox(
                height: 15,
              ),
              Text('같이 배달하시겠습니까?'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              print('취소');
              Get.back();
            },
            child: Text('취소'),
          ),
          TextButton(
            onPressed: () {
              print('확인');
              _postsController.joinPost(
                  postId: post.id!, userId: _userController.user.id!);
              Get.back();
            },
            child: Text('확인'),
          ),
        ]);
  }
}
