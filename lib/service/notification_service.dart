import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:women_safety_app/model/user_model.dart';

mixin NotificationService {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  Stream<List<String>> getListIdSender() {
    return _db
        .collection('friendrequests')
        .doc('T8GTEdpL8VaNQzdWu5ZF')
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
  // Stream<List<UserModel>> getListSender(){
  //   return
  //
}
