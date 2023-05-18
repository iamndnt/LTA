import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/child/notification_screens/body_noti.dart';
import 'package:women_safety_app/model/notification.dart';

import '../../model/user_model.dart';
import '../../service/database_service.dart';

// ignore: must_be_immutable
class NotificationScreen extends StatefulWidget {
  List<UserModel> listUserFromFireStore;
  List<MyNotification> listNotiFromFireStore;
  NotificationScreen(
      {super.key,
      required this.listUserFromFireStore,
      required this.listNotiFromFireStore});
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

FirebaseAuth _auth = FirebaseAuth.instance;
String currentId = _auth.currentUser!.uid;

class _NotificationScreenState extends State<NotificationScreen> {
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  late List<UserModel> listUser = widget.listUserFromFireStore;
  late List<UserModel> listUserHaveIdSender = [];

  String getNotiIdHaveCurrentUser() {
    debugPrint('ID current: ${currentId}');
    List<MyNotification> listNoti = widget.listNotiFromFireStore;
    for (int i = 0; i < listNoti.length; i++) {
      if (listNoti[i].ReceiverId == currentId) {
        return listNoti[i].NotificationId ?? '';
      }
    }
    debugPrint('ID current: ${listNoti[0].NotificationId}');
    return '';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: StreamBuilder(
            stream:
                DatabaseService().getListIdSender(getNotiIdHaveCurrentUser()),
            builder:
                (BuildContext context, AsyncSnapshot<List<String>?> snapshot) {
              List<String>? listIdSender = snapshot.data;
              for (int i = 0; i < listIdSender!.length; i++) {
                for (int j = 0; j < listUser.length; j++) {
                  if (listIdSender[i] == listUser[j].id) {
                    listUserHaveIdSender.add(listUser[j]);
                  }
                }
              }
              return ListView.builder(
                itemCount: listUser.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    child: ListTile(
                      leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(listUser[index].imageUrl ?? '')),
                      title: Text(
                          listUser[index].name! + " sent a friend request "),
                      trailing: Icon(Icons.person_add_alt_1_sharp),
                    ),
                  );
                },
              );
            }));
  }
}
