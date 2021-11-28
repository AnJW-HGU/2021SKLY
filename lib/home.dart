import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skly/chat/chatList.dart';
import 'package:skly/controller/navigationController.dart';
import 'package:skly/post/board.dart';
import 'package:skly/profile/myProfile.dart';
import 'package:skly/controller/chatListController.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final NavigationController _navController = Get.put(NavigationController());
  ChatListController chatListController = Get.put(ChatListController());

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final pageList = [
      BoardPage(),
      ChatListPage(
        chatListController: chatListController,
      ),
      MyProfilePage()
    ];
    return GetBuilder<NavigationController>(builder: (_) {
      return Scaffold(
        body: PageTransitionSwitcher(
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
            return FadeThroughTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: pageList[_navController.currentIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _navController.currentIndex,
          backgroundColor: colorScheme.primary,
          selectedItemColor: colorScheme.secondary,
          unselectedItemColor: colorScheme.surface,
          selectedLabelStyle: textTheme.caption,
          unselectedLabelStyle: textTheme.caption,
          onTap: (value) {
            _navController.changeIndex(value);
          },
          items: [
            BottomNavigationBarItem(
              label: '게시글',
              icon: Icon(
                Icons.menu_rounded,
              ),
            ),
            BottomNavigationBarItem(
              label: '채팅방',
              icon: Icon(Icons.chat_bubble_outline_rounded),
            ),
            BottomNavigationBarItem(
              label: '프로필',
              icon: Icon(Icons.person_outline_rounded),
            ),
          ],
        ),
      );
    });
  }
}
