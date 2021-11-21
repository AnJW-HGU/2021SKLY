import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPostPage extends StatelessWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    TextEditingController _storeTextEditing = TextEditingController();
    TextEditingController _contentTextEditing = TextEditingController();

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
              onPressed: () {
                Get.back();
              },
              child: Text(
                '게시',
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
                  controller: _storeTextEditing,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: colorScheme.onSurface, width: 1),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: colorScheme.secondary, width: 2),
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
                Container(
                  height: 40,
                  child: Center(
                    child: Text(
                      '주문 시간 선택',
                      style:
                          TextStyle(fontSize: 15, color: colorScheme.primary),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: colorScheme.onSurface, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                // 최대 인원 수 선택
                Container(
                  height: 40,
                  child: Center(
                    child: Text(
                      '최대 인원 수 선택',
                      style:
                          TextStyle(fontSize: 15, color: colorScheme.primary),
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: colorScheme.onSurface, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                // 모집글 내용
                TextFormField(
                  controller: _contentTextEditing,
                  maxLength: 50,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: colorScheme.onSurface, width: 1),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: colorScheme.secondary, width: 2),
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
  }
}
