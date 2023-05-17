import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:women_safety_app/child/notification_screens/notifications_page.dart';
import 'package:women_safety_app/model/user_model.dart';

// ignore: must_be_immutable
class AddFriend extends StatefulWidget {
  List<UserModel> listUserFromFireStore;
  AddFriend({super.key, required this.listUserFromFireStore});
 
  @override
  _AddFriendState createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {

  late TextEditingController phoneController ;

  bool isPhoneContain(String phone) {
    for (int i=0; i < (widget.listUserFromFireStore.length); i++) {
      if (phone == widget.listUserFromFireStore[i].phone){
        return true;
      }
    }
    return false;
  }

  // To find id & name has phone you need
  List<String> idandNameHasPhoneNumber(String phone){
    List<String> listContainIdAndName= [];
    for (int i=0; i < (widget.listUserFromFireStore.length); i++) {
      if (phone == widget.listUserFromFireStore[i].phone){
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
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Spacer(),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationScreen()));
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
            child: InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 26, vertical: 10),
                decoration: BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [Colors.purple.shade600, Colors.purple.shade200]),
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

              onTap: (){

                  bool isContainerPhone = isPhoneContain(phoneController.text);
                  if (isContainerPhone == true) {
                    Fluttertoast.showToast(msg: "Send friend request succesfull");
                  } else {
                    Fluttertoast.showToast(msg: "Phone is not register");
                  }
                  
              },
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
        ],
      ),
    );
  }
}
