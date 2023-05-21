import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:women_safety_app/child/notification_screens/notifications_page.dart';
import 'package:women_safety_app/db/auth_services.dart';
import 'package:women_safety_app/model/notification.dart';
import 'package:women_safety_app/model/user_model.dart';
import 'package:women_safety_app/service/notification_service.dart';

import '../../db/user_model_services.dart';

// ignore: must_be_immutable
class AddFriend extends StatefulWidget {
  List<UserModel> listUserFromFireStore;
  AddFriend({super.key, required this.listUserFromFireStore});

  @override
  _AddFriendState createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
  late TextEditingController phoneController;
  late bool appear;
  bool isPhoneContain(String phone) {
    for (int i = 0; i < (widget.listUserFromFireStore.length); i++) {
      if (phone == widget.listUserFromFireStore[i].phone) {
        return true;
      }
    }
    return false;
  }

  // To find id & name has phone you need
  List<String> idandNameHasPhoneNumber(String phone) {
    List<String> listContainIdAndName = [];
    for (int i = 0; i < (widget.listUserFromFireStore.length); i++) {
      if (phone == widget.listUserFromFireStore[i].phone) {
        listContainIdAndName.add(widget.listUserFromFireStore[i].id ?? '');
        listContainIdAndName.add(widget.listUserFromFireStore[i].name ?? '');
        break;
      }
    }
    return listContainIdAndName;
  }


  @override
  void initState() {
    phoneController = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    appear = false;
    MobileScannerController controller = MobileScannerController();
    bool isScanCompleted = false;

    Widget QrScan(){
      return Container(
        width: width*0.25,
        height: height*0.4,
        padding: EdgeInsets.all(16),
        child: Stack(
          children: [
            MobileScanner(
                controller: controller,
                onDetect: (
                    barcode,
                    args,
                    ) {
                  if (!isScanCompleted) {
                    // String code = barcode.image as String;
                    String code = barcode.rawValue ?? '---';

                    isScanCompleted = true;

                    phoneController.text=code;
                    Fluttertoast.showToast(msg: "Scan successfully!");
                  }
                }),
            // QRScannerOverlay(overlayColour)
          ],
        )
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Spacer(),
            IconButton(
                onPressed: () async {
                  UserService userService = UserService();
                    var listUsers = (await userService.allUsersOnce);

                    debugPrint('Length of List User: ${listUsers?.length}');
                    listUsers?.forEach((element) {
                      debugPrint('User: ${element.phone}');
                    },);

                  NotificationService notiService = NotificationService();
                  var listNoti = (await notiService.allNotisOnce);
                  debugPrint('Length of List Noti: ${listNoti?.length}');
                  listNoti?.forEach(
                    (element) {
                      debugPrint('User: ${element.ReceiverId}');
                    },
                  );

                   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationScreen(listUserFromFireStore: listUsers??[],
                            listNotiFromFireStore: listNoti ?? []),
                      ));
                },
                icon: Icon(Icons.notifications))
          ],
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * 0.03,
          ),
          Text(
            'add new friend'.toUpperCase(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Center(
            child: Container(
              height: 1,
              width: width * 0.8,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Text(
            'Enter phone number of friend you want to add',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: TextField(
                controller: phoneController,
                onChanged: (value) {
                  debugPrint('phoneController.text ${phoneController.text}');
                },
                textAlign: TextAlign.start,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Phone Number ",
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.bold, letterSpacing: 1.8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        width: 1, style: BorderStyle.solid, color: Colors.blue),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: EdgeInsets.all(12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        width: 1, style: BorderStyle.solid, color: Colors.grey),
                  ),
                )),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 26, vertical: 10),
                    decoration: BoxDecoration(
                        gradient: new LinearGradient(colors: [
                          Colors.purple.shade600,
                          Colors.purple.shade200
                        ]),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 4,
                              color: Colors.blue.shade200,
                              offset: Offset(2, 2))
                        ]),
                    child: Text(
                      "Scan QR".toUpperCase(),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.7),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: height,
                          width: width,
                          child: QrScan(),
                        );
                      },
                    );
                  },
                ),
                SizedBox(width: 20,),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 26, vertical: 10),
                    decoration: BoxDecoration(
                        gradient: new LinearGradient(colors: [
                          Colors.purple.shade600,
                          Colors.purple.shade200
                        ]),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 4,
                              color: Colors.blue.shade200,
                              offset: Offset(2, 2))
                        ]),
                    child: Text(
                      "Add".toUpperCase(),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.7),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: () async {
                    bool isContainerPhone = isPhoneContain(phoneController.text);
                    if (isContainerPhone != true) {
                      Fluttertoast.showToast(msg: "Phone is not register");
                      return;
                    }
                    List<String> idUserHasPhoneNumber = idandNameHasPhoneNumber(phoneController.text);
                    String idUserReceiver='';
                    idUserReceiver = idUserHasPhoneNumber[0];

                    NotificationService noti = NotificationService();
                    // List<MyNotification>? myNotifications = await noti.allNotisOnce;
                    // debugPrint('myNotifications.length ${myNotifications?.length}');
                    String? idNoti = await noti.getIdNotiByIdSender(idUserReceiver);
                    FirebaseAuth _auth = FirebaseAuth.instance;
                    String currentId = _auth.currentUser!.uid;
                    if (idNoti == '') {
                      MyNotification myNoti = MyNotification();

                      myNoti.ReceiverId = idUserReceiver;
                      myNoti.SenderId?.add(currentId);

                      noti.creatNotificationToFireStore(myNoti,currentId);
                    } else {
                      noti.addSender(idNoti ??'', currentId);
                    }
                    debugPrint('idNoti: ${idNoti}');
                    Fluttertoast.showToast(msg: "Send friend request succesfull");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
