import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skly/controller/postController.dart';

class SearchPlacePage extends StatelessWidget {
  const SearchPlacePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    PostController _postController = Get.find<PostController>();
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(bottom: 5),
          child: TextFormField(
            controller: _postController.placeTextEditing,
            cursorColor: colorScheme.secondary,
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
                color: colorScheme.surface,
              ),
            ),
          ),
        ),
        // Text('배달 장소 검색', style: TextStyle(fontSize: 16),),
        backgroundColor: colorScheme.primary,
        leading: IconButton(
          onPressed: () {Get.back();},
          icon: Icon(Icons.arrow_back_rounded, color: Colors.white,),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Text('hi'),
        ),
      ),
    );
  }
}
