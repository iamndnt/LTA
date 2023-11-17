import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:women_safety_app/child/post.dart';
import 'package:women_safety_app/components/AlertPost.dart';

import '../components/PrimaryButton.dart';
import '../components/custom_textfield.dart';

class AlertScreen extends StatefulWidget {
  @override
  _AlertScreenState createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  late Position _currentPosition;
  late String _currentAddress="......";
  late String _currentCity="Hà Nội";
  bool isSaving = false;
  bool check=false;

  TextEditingController titleC = TextEditingController();
  TextEditingController contentC = TextEditingController();
  _getCurrentLocation() {
    Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude,
          _currentPosition.longitude
      );

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.locality!=""?place.locality!:_currentCity}, ${place.postalCode}, ${place.country}";
        if(place.locality!="")
            _currentCity = place.locality!;
      });
    } catch (e) {
      print(e);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    _getCurrentLocation();
    super.initState();
  }
  saveAlert() async {
    setState(() {
      isSaving = true;
    });
    await FirebaseFirestore.instance
        .collection('alert')
        .add({'author_id': FirebaseAuth.instance.currentUser!.uid,
              'title': titleC.text,
              'content': contentC.text,
              'place': _currentCity,
              'time' : DateTime.now().toString(),
    }).then((value) {
      setState(() {
        titleC.text='';
        contentC.text='';
        isSaving = false;
        Fluttertoast.showToast(msg: 'Đăng cảnh báo thành công');
      });
    });
  }

  showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("Thêm cảnh báo"),
            content: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        hintText: 'Nhập tiêu đề:',
                        controller: titleC,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: contentC,
                        hintText: 'Nhập nội dung:',
                        maxLines: 3,
                      ),
                    ),
                  ],
                )),
            actions: [
              PrimaryButton(
                  title: "Lưu",
                  onPressed: () {
                    saveAlert();
                    Navigator.pop(context);
                  }),
              TextButton(
                  child: Text("Hủy"),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    List<AlertPost> _post = [];
    return  Scaffold(
      body: SafeArea(
          child: Container(
            decoration:  BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
                  Color.fromRGBO(165, 204, 255, 1),
                  Color.fromRGBO(115, 104, 226, 1)
                ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('alert')
                  .orderBy('time', descending: true)
                  .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if(snapshot.data!.docs.length!=_post.length){
                    for(int i=0;i<snapshot.data!.docs.length;i++){
                      final data = snapshot.data!.docs[i];
                      DateTime dt = DateTime.parse(data['time']);
                      AlertPost tmp = new AlertPost('', data['title'], data['content'], data['author_id'], data['place'], dt);
                      String pl =data['place'].toString();
                      if(pl.compareTo(_currentCity)==0)
                        _post.add(tmp);
                    }
                  }


                  check = true;
                  return ListView(
                    children: <Widget>[
                      Column(
                        children: [
                          Container(
                            height: 160,
                            width: MediaQuery.of(context).size.width,
                            decoration:  BoxDecoration(
                                gradient: LinearGradient(colors: <Color>[
                                  Color.fromRGBO(165, 204, 255, 1),
                                  Color.fromRGBO(115, 104, 226, 1)
                                ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
                            child: Padding(
                              padding:  EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Chúc bạn một ngày tốt lành!",
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Vị trí hiện tại của bạn: "+_currentAddress,
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 8.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Chia sẻ cảnh báo!",
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.6),
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            showAlert(context);
                                          },
                                          icon:  Icon(Icons.add,
                                              color: Colors.white)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(35.0),
                                      topRight: Radius.circular(35.0))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 20.0, top: 20.0, bottom: 10.0),
                                    child: Text(
                                        "Cảnh báo tại vị trí gần bạn",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        )
                                    ),

                                  ),
                                  Post( post: _post),
                                ],
                              ))
                        ],
                      )

                    ],
                  );
                }
            ),
          )),
    );
  }
}
