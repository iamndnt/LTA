import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


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
  void creatNotificationToFireStore(MyNotification myNotification,String idSender) async {
    DocumentReference doc = _db.collection('friendrequests').doc();
    String doc_id = doc.id;
    if (myNotification.NotificationId == null) myNotification.NotificationId=doc_id;
    doc
        .set(myNotification.toJson())
        .then((value) => print('myNotification added successfully'))
        .catchError((error) => print('Failed to add a notification'));
    addSender(myNotification.NotificationId ?? 'NULL',idSender);
  }



  void addNotificationToFireStore(MyNotification myNotification) async {
    DocumentReference doc = _db.collection('friendrequests').doc();
    String doc_id = doc.id;
    if (myNotification.NotificationId == null) myNotification.NotificationId=doc_id;
    FirebaseAuth _auth = FirebaseAuth.instance;
    String currentId = _auth.currentUser!.uid;
     
    doc
        .set(myNotification.toJson())
        .then((value) => print('myNotification added successfully'))
        .catchError((error) => print('Failed to add a notification'));
    addSender(myNotification.NotificationId ?? 'NULL',currentId);
  }

  void addSender(String idNoti,String idSender){
     _db.collection('friendrequests').doc(idNoti).update({
        "SenderId": FieldValue.arrayUnion([idSender]),
      });
  }

  void deleteSender(String idNoti,String idSender){
     _db.collection('friendrequests').doc(idNoti).update({
        "SenderId": FieldValue.arrayRemove([idSender]),
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

  Future<String>? getIdNotiByIdSender(String? idReceiver) async {
    List<MyNotification>? temp = await allNotisOnce;
    String name='';
    for (int i = 0; i < (temp?.length ?? 0); i++) {
      if ( (temp?[i].ReceiverId ?? 'NULL').compareTo(idReceiver ?? '') == 0) {
        name = temp?[i].NotificationId ?? 'NULL';
        break;
      }
    }
    return name;
  }
}
