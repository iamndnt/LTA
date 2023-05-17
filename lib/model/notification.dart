import 'package:cloud_firestore/cloud_firestore.dart';

class MyNotification {
  String? ReceiverId;
  List<String>? SenderId;
  String? NotificationId;
  MyNotification({this.ReceiverId, this.SenderId, this.NotificationId});

  Map<String, dynamic> toJson() => {
        'ReceiverId': ReceiverId,
        'SenderId': SenderId,
        'NotificationId': NotificationId,
      };
  factory MyNotification.fromJson(Map<String, dynamic>? data) {
    final String? ReceiverId = data?['ReceiverId'];
    final List<String>? SenderId = [];
    final String? NotificationId = data?['NotificationId'];
    List.from(data?['SenderId']).forEach((element) {
      SenderId?.add(element);
    });
    return MyNotification(
        ReceiverId: ReceiverId,
        SenderId: SenderId,
        NotificationId: NotificationId);
  }

  factory MyNotification.test() {
    String? ReceiverId = "id_receider";
    List<String>? SenderId = ["List Test"];
    String? NotificationId = "id_notification";
    return MyNotification(
        ReceiverId: ReceiverId,
        SenderId: SenderId,
        NotificationId: NotificationId);
  }
  factory MyNotification.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return MyNotification.fromJson(documentSnapshot.data());
  }
}
