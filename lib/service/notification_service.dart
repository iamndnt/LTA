import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:women_safety_app/model/user_model.dart';

import '../model/notification.dart';

class NotificationService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<String>> getListIdSender(String notiId) {
    return _db
        .collection('friendrequests')
        .doc(notiId)
        .snapshots()
        .map((documentSnapshot) {
      final data = documentSnapshot.data();
      debugPrint('data sender length: ${data?.length}');
      List<String>? list_sender = [];
      List.from(data?['SenderId']).forEach((element) {
        list_sender.add(element);
      });
      return list_sender;
    });
  }

  List<MyNotification>? _usersFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    return querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        return MyNotification.fromDocumentSnapshot(documentSnapshot);
      }
      return MyNotification.test();
    }).toList();
  }

  Future<List<MyNotification>?> get allNotisOnce {
    return _db.collection('friendrequests').get().then(_usersFromQuerySnapshot);
  }
}
