import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

class PostController extends GetxController {
  TimeOfDay closeTime =
  TimeOfDay(hour: DateTime
      .now()
      .hour, minute: DateTime
      .now()
      .minute);
  int people = 100;
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

  // void peoplePicker(BuildContext context) async {
  //   NumberPicker(
  //     initialValue: people,
  //     minValue: 2,
  //     maxValue: 100,
  //     decimalPlaces: 1,
  //     onChanged: (value) {
  //       this.people = value;
  //     }
  //   ),
  //   update();
  // }

  void submitPost() {
    if (this.storeTextEditing.text != null &&
        this.contentTextEditing.text != null &&
        this.isPickCloseTime &&
        this.isPickPeople) {
      print('add Post 구현해야함');
    }
    else {
      print('snack bar로 unFill 알려주기');
    }
    update();
  }
}
