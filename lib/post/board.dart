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
    return GetBuilder<PostsController>(
      builder: (_) {
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
                            _buildCategory(context, '전체', 'https://firebasestorage.googleapis.com/v0/b/skly-715e2.appspot.com/o/category%2Fall.png?alt=media&token=59140804-0fcd-4139-b563-711c7ae9a9bb'),
                            _buildCategory(context, '한식', 'https://firebasestorage.googleapis.com/v0/b/skly-715e2.appspot.com/o/category%2Fbibimbap.png?alt=media&token=6e6b121f-fa07-427c-b769-555e37d97776'),
                            _buildCategory(context, '분식', 'https://firebasestorage.googleapis.com/v0/b/skly-715e2.appspot.com/o/category%2Fdduck.png?alt=media&token=dff61776-77f9-4f0a-829d-952d59588de3'),
                            _buildCategory(context, '카페', 'https://firebasestorage.googleapis.com/v0/b/skly-715e2.appspot.com/o/category%2Fdounut.png?alt=media&token=83e44dc2-8a1c-4e40-b2ba-411bf21a48aa'),
                            _buildCategory(context, '일식', 'https://firebasestorage.googleapis.com/v0/b/skly-715e2.appspot.com/o/category%2Fsusi.png?alt=media&token=7ebe5d51-6ad9-4750-9a2d-12c8ccd0e3b9'),
                          ],
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildCategory(context, '치킨', 'https://firebasestorage.googleapis.com/v0/b/skly-715e2.appspot.com/o/category%2Fchicken.png?alt=media&token=13bb6641-04ac-4ccc-a637-40008d4870f9'),
                            _buildCategory(context, '피자', 'https://firebasestorage.googleapis.com/v0/b/skly-715e2.appspot.com/o/category%2Fpizza.png?alt=media&token=e0945ce9-ec71-4b5a-84b5-4880f2754c94'),
                            _buildCategory(context, '양식', 'https://firebasestorage.googleapis.com/v0/b/skly-715e2.appspot.com/o/category%2Fpasta.png?alt=media&token=a21ad58f-9276-4b61-8b68-e316035f0d5e'),
                            _buildCategory(context, '중식', 'https://firebasestorage.googleapis.com/v0/b/skly-715e2.appspot.com/o/category%2Fblack.png?alt=media&token=e155274a-0eff-4f31-879f-fdc23ff45287'),
                            _buildCategory(context, '버거', 'https://firebasestorage.googleapis.com/v0/b/skly-715e2.appspot.com/o/category%2Fburger.png?alt=media&token=1bf60f0d-7909-455f-a497-77de04f0e55b'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                backgroundColor: colorScheme.primary,
              ),
              StreamBuilder<List<Post>>(
                  stream: _postsController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isNotEmpty) {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return Column(
                              children: [
                                (snapshot.data![index].isClose ?? false)
                                    ? _buildClosePost(
                                        context, snapshot.data![index])
                                    : _buildPost(
                                        context, snapshot.data![index]),
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
                      } else {
                        return SliverToBoxAdapter(
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 70),
                                child: Text(
                                  '모집글이 존재하지 않습니다 :<',
                                  style: TextStyle(
                                      fontSize: 15, color: colorScheme.primary),
                                ),
                              ),
                            ));
                      }
                    } else if (!snapshot.hasData) {
                      return SliverToBoxAdapter(
                          child: LinearProgressIndicator());
                    } else {
                      print('error');
                      return SliverToBoxAdapter(
                          child: Center(
                        child: Text(
                          '에러가 발생했습니다 :<',
                          style: TextStyle(
                              fontSize: 16, color: colorScheme.primary),
                        ),
                      ));
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
      },
    );
  }

  Widget _buildCategory(BuildContext context, String category, String storageLink) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        _postsController.changeCategory(category: category);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: colorScheme.primary,
              child: Image.network(
                storageLink,
                fit: BoxFit.fill,
              ),
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
        if (post.userId != _userController.user.id) {
          if (!post.peopleJoin!.contains(_userController.user.id) &&
              post.people! > post.peopleJoin!.length) {
            _postDialog(context, post);
          } else if (post.people! <= post.peopleJoin!.length) {
            _printDialog(context, post, '정원이 마감된 모집글입니다.');
          } else {
            _printDialog(context, post, '이미 모집글에 참여하셨습니다.');
          }
        }
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

  Future<dynamic> _printDialog(
      BuildContext context, Post post, String content) {
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
              Text(content),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              print('확인');
              Get.back();
            },
            child: Text('확인'),
          ),
        ]);
  }
}
