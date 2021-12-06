import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpostal/kpostal.dart';
import 'package:skly/model/post.dart';
import 'package:skly/controller/userController.dart';
import 'package:skly/repository/postRepository.dart';

class PostController extends GetxController {
  String category = '한식';
  TextEditingController storeTextEditing = TextEditingController();
  // TextEditingController placeTextEditing = TextEditingController();
  String address = '';
  TimeOfDay closeTime =
  TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  int people = 2;
  TextEditingController contentTextEditing = TextEditingController();

  bool isPickPlace = false;
  bool isPickCloseTime = false;
  bool isPickPeople = false;

  UserController _userController = Get.put(UserController());

  void placePicker(BuildContext context, Kpostal result) {
    this.address = result.address;
    if (this.address != null) {
      this.isPickPlace = !this.isPickPlace;
    }
    update();
  }

  void closeTimePicker(BuildContext context) async {
    this.closeTime = await showTimePicker(
      context: context,
      initialTime: closeTime,
      initialEntryMode: TimePickerEntryMode.input,
    ) as TimeOfDay;
    this.isPickCloseTime = true;
    update();
  }

  Future<bool> submitPost(BuildContext context) async {
    final colorScheme = Theme.of(context).colorScheme;
    if (this.storeTextEditing.text == null) {
      Get.snackbar(
        '등록 실패',
        '가게 이름을 적어주세요!',
        backgroundColor: colorScheme.secondary,
        snackPosition: SnackPosition.TOP,
        duration: Duration(milliseconds: 1000),
      );
      return false;
    } else if (this.address == null) {
      Get.snackbar(
        '등록 실패',
        '배달 장소를 선택해 주세요!',
        backgroundColor: colorScheme.secondary,
        snackPosition: SnackPosition.TOP,
        duration: Duration(milliseconds: 1000),
      );
      return false;
    } else if (!this.isPickCloseTime) {
      Get.snackbar(
        '등록 실패',
        '주문 시간을 선택해 주세요!',
        backgroundColor: colorScheme.secondary,
        snackPosition: SnackPosition.TOP,
        duration: Duration(milliseconds: 1000),
      );
      return false;
    } else if (!this.isPickPeople) {
      Get.snackbar(
        '등록 실패',
        '최대 인원을 선택해 주세요!',
        backgroundColor: colorScheme.secondary,
        snackPosition: SnackPosition.TOP,
        duration: Duration(milliseconds: 1000),
      );
      return false;
    } else if (this.contentTextEditing.text == null) {
      Get.snackbar(
        '등록 실패',
        '모집글 내용을 적어주세요!',
        backgroundColor: colorScheme.secondary,
        snackPosition: SnackPosition.TOP,
        duration: Duration(milliseconds: 1000),
      );
      return false;
    } else {
      Post post = Post(
        userId: _userController.user.id,
        store: this.storeTextEditing.text,
        category: this.category,
        content: this.contentTextEditing.text,
        people: this.people,
        peopleJoin: [_userController.user.id].cast<String>(),
        place: this.address,
        closeTime: Timestamp.fromDate(DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            this.closeTime.hour,
            this.closeTime.minute)),
        writeTime: Timestamp.now(),
        isClose: false,
      );
      await PostRepository().setPost(post);
      return true;
    }
  }
}
