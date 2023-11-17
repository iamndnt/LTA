import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/child/notification_screens/body_noti.dart';
import 'package:women_safety_app/db/user_model_services.dart';
import 'package:women_safety_app/model/notification.dart';
import 'package:women_safety_app/service/notification_service.dart';

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
  String? idNotiCurrent = '';

  String? getNotiIdHaveCurrentUser() {
    debugPrint('huy2.phan Current Id: ${currentId}');
    List<MyNotification> listNoti = widget.listNotiFromFireStore;
    for (int i = 0; i < listNoti.length; i++) {
      if (listNoti[i].ReceiverId == currentId) {
        debugPrint('ID current: ${listNoti[0].NotificationId}');
        idNotiCurrent = listNoti[i].NotificationId ?? '';
        return listNoti[i].NotificationId ?? '';
      }
    }
    debugPrint('ID current: ${listNoti[0].NotificationId}');
    return null;
  }

  List<UserModel> listOfSenderFriendsRequest(List<String>? listIdSender) {
    List<UserModel> rs = [];
    for (int i = 0; i < (listIdSender?.length ?? 0); i++) {
      for (int j = 0; j < (widget.listUserFromFireStore.length); j++) {
        if (widget.listUserFromFireStore[j].id == listIdSender?[j]) {
          rs.add(widget.listUserFromFireStore[j]);
        }
      }
    }
    return rs;
  }

  void display() {
    for (int i = 0; i < widget.listNotiFromFireStore.length; i++) {
      debugPrint('listNoti: ${widget.listNotiFromFireStore[i].ReceiverId}');
    }
  }

  bool isFriendRqFireStoreHaveIdReceiver() {
    for (int i = 0; i < widget.listNotiFromFireStore.length; i++) {
      if (currentId == widget.listNotiFromFireStore[i].ReceiverId) {
        return true;
      }
    }
    return false;
  }

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    display();
    return Scaffold(
        appBar: AppBar(),
        body: (isFriendRqFireStoreHaveIdReceiver() == false)
            ? Center(
                child: Text('Không có lời mời kết bạn nào'),
              )
            : StreamBuilder(
                stream: DatabaseService()
                    .getListIdSender(getNotiIdHaveCurrentUser() ?? ''),
                builder: (BuildContext context,
                    AsyncSnapshot<List<String>?> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Có lỗi đã xảy ra: ${snapshot.error}');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.data == null) {
                    return Column(
                      children: const [
                        CircularProgressIndicator(),
                      ],
                    );
                  }
                  List<String>? listIdSender = snapshot.data;
                  if (listIdSender?.length == 0) {
                    return Center(
                      child: Text('Bạn không có lời mời kết bạn'),
                    );
                  }
                  listUserHaveIdSender.clear();
                  debugPrint('lengthlistidsender: ${listIdSender?.length}');
                  for (int i = 0; i < listIdSender!.length; i++) {
                    for (int j = 0; j < listUser.length; j++) {
                      if (listIdSender[i] == listUser[j].id) {
                        debugPrint('idSender: ${listIdSender[i]}');
                        debugPrint('Name: ${listUser[j].name}');
                        debugPrint('User: ${listUser[j].id}');
                        listUserHaveIdSender.add(listUser[j]);
                      }
                    }
                  }
                  listUserHaveIdSender.forEach((element) {
                    debugPrint('ushaveid ${element.id}');
                  });

                  return ListView.builder(
                    itemCount: listUserHaveIdSender.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.0),
                        child: ListTile(
                          leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(listUserHaveIdSender[index].imageUrl ?? '')),
                          title: Text((listUserHaveIdSender[index].name!.length > 10)
                              ? ('${listUserHaveIdSender[index].name!.substring(1, 10)}... ')
                              : ('${listUserHaveIdSender[index].name!}') +
                                  " đã gửi lời mời kết bạn "),
                          //trailing: Icon(Icons.person_add_alt_1_sharp),
                          trailing: Column(
                            children: [
                              Spacer(),
                              myAcceptFriendRequestButton(
                                  'Chấp nhậnw',
                                  currentId,
                                  listUserHaveIdSender[index].id ?? '',
                                  idNotiCurrent ?? ''),
                              Spacer(),
                              myAcceptFriendRequestButton(
                                  'Xóa',
                                  currentId,
                                  listUserHaveIdSender[index].id ?? '',
                                  idNotiCurrent ?? ''),
                              Spacer(),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }));
  }

  Widget myAcceptFriendRequestButton(
      String ACCEPT, String currentUser, String idSender, String idNoti) {
    bool isAccept = ACCEPT == 'Chấp nhận';

    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Color.fromARGB(1, 209, 103, 186),
        ),
        child: Text(
          '${ACCEPT}',
          style: TextStyle(
            color: (isAccept == true) ? (Colors.blueAccent) : (Colors.red[400]),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      onTap: () {
        if (isAccept == true) {
          UserService userService = UserService();
          userService.addFriendsIntoListFriends(currentUser, idSender);
          userService.addFriendsIntoListFriends(idSender, currentUser);

        }
        NotificationService notificationService = NotificationService();
        notificationService.deleteSender(idNoti, idSender);

        setState(() {});
      },
    );
  }
}
