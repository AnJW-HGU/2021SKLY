import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skly/controller/postController.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    PostController _postController = Get.put(PostController());

    return GetBuilder<PostController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              '모집글 등록',
              style: TextStyle(fontSize: 15, color: colorScheme.surface),
            ),
            titleSpacing: 0,
            backgroundColor: colorScheme.primary,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_rounded),
              color: colorScheme.surface,
              onPressed: () {
                _postController.submitPost();
                Get.back();
              },
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (_postController.submitPost()) {
                      Get.back();
                    }
                    else {
                      Get.snackbar(
                        '등록 실패',
                        '내용을 다 채워주세요!',
                        backgroundColor: colorScheme.secondary,
                        snackPosition: SnackPosition.TOP,
                        duration: Duration(milliseconds: 1000),
                      );
                    }
                  },
                  child: Text(
                    '완료',
                    style: TextStyle(color: colorScheme.secondary),
                  ))
            ],
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 55, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _postController.storeTextEditing,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: colorScheme.onSurface, width: 1),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: colorScheme.secondary, width: 2),
                          ),
                          border: UnderlineInputBorder(),
                          hintText: '가게 이름을 적어주세요',
                          hintStyle: TextStyle(
                            color: colorScheme.primary,
                          )),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    // 주문시간 선택
                    GestureDetector(
                      onTap: () {
                        _postController.closeTimePicker(context);
                      },
                      child: Container(
                        height: 40,
                        child: Center(
                          child: _postController.isPickCloseTime
                              ? Text(
                                  '${_postController.closeTime.hour} : ${_postController.closeTime.minute}',
                                  style: TextStyle(
                                      fontSize: 15, color: colorScheme.primary),
                                )
                              : Text(
                                  '주문 시간 선택',
                                  style: TextStyle(
                                      fontSize: 15, color: colorScheme.primary),
                                ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: colorScheme.onSurface, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    // 최대 인원 수 선택
                    GestureDetector(
                      onTap: () {
                        print('number picker 사용');
                      },
                      child: Container(
                        height: 40,
                        child: Center(
                          child: Text(
                            '최대 인원 수 선택',
                            style: TextStyle(
                                fontSize: 15, color: colorScheme.primary),
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: colorScheme.onSurface, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    // 모집글 내용
                    TextFormField(
                      controller: _postController.contentTextEditing,
                      maxLength: 50,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: colorScheme.onSurface, width: 1),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: colorScheme.secondary, width: 2),
                          ),
                          border: UnderlineInputBorder(),
                          labelText: '모집글 내용',
                          labelStyle: TextStyle(
                            color: colorScheme.primary,
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
