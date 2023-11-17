import 'package:flutter/material.dart';

import 'package:women_safety_app/child/AlerScreen.dart';
import 'package:women_safety_app/child/bottom_screens/add_contacts.dart';
import 'package:women_safety_app/child/bottom_screens/chat_page.dart';
import 'package:women_safety_app/child/bottom_screens/child_home_page.dart';
import 'package:women_safety_app/child/bottom_screens/profile_page.dart';

import '../chatbox/final_chatbox.dart';

class BottomPage extends StatefulWidget {
  BottomPage({Key? key}) : super(key: key);

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int currentIndex = 0;
  List<Widget> pages = [
    HomeScreen(),
    AddContactsPage(),
    ChatPage(),
    AlertScreen(),
    MyChatBox(),
    ProfilePage(),
  ];

  onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: onTapped,
        items: [
          BottomNavigationBarItem(
              label: 'Trang Chủ',
              icon: Icon(
                Icons.home,
              )),
          BottomNavigationBarItem(
              label: 'Liên Hệ',
              icon: Icon(
                Icons.contacts,
              )),
          BottomNavigationBarItem(
              label: 'Nhắn Tin',
              icon: Icon(
                Icons.chat,
              )),
          BottomNavigationBarItem(
              label: 'Cảnh báo',
              icon: Icon(
                Icons.add_alert_rounded,
              )),
          BottomNavigationBarItem(
              label: 'Chatbox',
              icon: Icon(
                Icons.question_mark,
              )),
          BottomNavigationBarItem(
              label: 'Cá Nhân',
              icon: Icon(
                Icons.person,
              )),

        ],
      ),
    );
  }
}
