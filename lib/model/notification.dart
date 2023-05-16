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
}
