import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:skly/model/post.dart';
import 'package:skly/repository/postRepository.dart';

class PostController extends GetxController {
  TimeOfDay closeTime =
  TimeOfDay(hour: DateTime
      .now()
      .hour, minute: DateTime
      .now()
      .minute);
  int people = 0;
  TextEditingController storeTextEditing = TextEditingController();
  TextEditingController contentTextEditing = TextEditingController();

  bool isPickCloseTime = false;
  bool isPickPeople = false;

  void closeTimePicker(BuildContext context) async {
    this.closeTime = await showTimePicker(
      context: context,
      initialTime: closeTime,
      initialEntryMode: TimePickerEntryMode.input,
    ) as TimeOfDay;
    this.isPickCloseTime = true;
    update();
  }

  // void peoplePicker(BuildContext context) {
  //   Material(
  //     child: showMaterialNumberPicker(
  //         context: context,
  //         initialValue: people,
  //         minValue: 2,
  //         maxValue: 20,
  //         step: 1,
  //         onChanged: (value) {
  //           this.people = value;
  //         }
  //     ),
  //   );
  //   this.isPickPeople = true;
  //   update();
  // }

  bool submitPost() {
    if (this.storeTextEditing.text != null &&
        this.contentTextEditing.text != null &&
        this.isPickCloseTime &&
        this.isPickPeople) {
      // Post post = Post()
      // PostRepository().setPost(post);
      return true;
    }
    else {
      return false;
    }
    update();
  }
}
