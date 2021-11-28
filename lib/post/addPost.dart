import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
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
                Get.back();
              },
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    bool _postValidation = await _postController.submitPost(context);
                    if (_postValidation) {
                      Get.back();
                    }
                    else {
                      print('validation error');
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
                    // 가게 이름
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
                      height: 10,
                    ),
                    // 배달 장소
                    TextFormField(
                      controller: _postController.placeTextEditing,
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
                          hintText: '배달 장소를 적어주세요',
                          hintStyle: TextStyle(
                            color: colorScheme.primary,
                          ),),
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
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              '최대 인원 선택',
                              style: TextStyle(
                                  fontSize: 15, color: colorScheme.primary),
                            ),
                          ),
                          NumberPicker(
                            value: _postController.people,
                            minValue: 2,
                            maxValue: 20,
                            onChanged: (value) {
                              _postController.people = value;
                              _postController.isPickPeople = true;
                              _postController.update();
                            },
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: colorScheme.onSurface, width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    SizedBox(
                      height: 15,
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
