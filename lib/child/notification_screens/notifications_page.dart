import 'package:flutter/material.dart';
import 'package:women_safety_app/child/notification_screens/body_noti.dart';
import 'package:women_safety_app/model/notification.dart';

import '../../service/database_service.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

   late Stream<List<String>> listIdSender = DatabaseService().getListIdSender();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: BodyNoti()
      // body: 
    );
  }
}
