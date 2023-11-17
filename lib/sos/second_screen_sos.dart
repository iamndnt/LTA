import 'dart:async';

import 'package:background_sms/background_sms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../db/db_services.dart';
import '../model/contactsm.dart';

class SecondScreenSOS extends StatefulWidget {
  const SecondScreenSOS({Key? key}) : super(key: key);

  @override
  State<SecondScreenSOS> createState() => _SecondScreenSOSState();
}

class _SecondScreenSOSState extends State<SecondScreenSOS> {

  int seconds=10;
  int check=0;
  late Timer timer;
  Position? _curentPosition;
  String? _curentAddress;

  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    _getPermission();
    _getCurrentLocation();
    super.initState();
  }
  _getPermission() async => await [Permission.sms].request();
  _getCurrentLocation() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _curentPosition = position;
        print(_curentPosition!.latitude);
        _getAddressFromLatLon();
      });
    }).catchError((e) {
    });
  }

  _sendSms(String phoneNumber, String message, {int? simSlot}) async {
    SmsStatus result = await BackgroundSms.sendMessage(
        phoneNumber: phoneNumber, message: message, simSlot: 1);
    if (result == SmsStatus.sent) {
      print("Sent");
      Fluttertoast.showToast(msg: "Đã gửi");
    } else {
      Fluttertoast.showToast(msg: "Gửi thất bại");
    }
  }
  _callNumber(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }
  _isPermissionGranted() async => await Permission.sms.status.isGranted;
  getAndSendSms() async {
    List<TContact> contactList = await DatabaseHelper().getContactList();

    String messageBody =
        "https://maps.google.com/?daddr=${_curentPosition!.latitude},${_curentPosition!.longitude}";
    if (await _isPermissionGranted()) {
      int dem=0;
      contactList.forEach((element) {
        dem++;
      });
      if(dem==0)
        Fluttertoast.showToast(msg: "Thêm người vào danh sách tin cậy");

      contactList.forEach((element) {
        _sendSms("${element.number}", "Tôi đang gặp sự cố. Hãy tới giúp tôi qua địa chỉ : $messageBody");
      });
      contactList.forEach((element) {
        _callNumber(element.number);

      });
    } else {
      Fluttertoast.showToast(msg: "Lỗi!");
    }
  }
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Quyền truy cập vị trị không khả dụng. Vui lòng bật định vị')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Quyền truy cập vị trị không khả dụng')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Quyền truy cập vị trị không khả dụng')));
      return false;
    }
    return true;
  }
  _getAddressFromLatLon() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _curentPosition!.latitude, _curentPosition!.longitude);

      Placemark place = placemarks[0];
      setState(() {
        _curentAddress =
        "${place.locality},${place.postalCode},${place.street},";
      });
    } catch (e) {
    }
  }
  void startTimer(){
    timer=Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if(seconds!=0)
          seconds--;
        else{
          if(check==0)
            getAndSendSms();
          check=1;
        }

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        color: Colors.red,
        child: Column(
          children: [
          Spacer(),
          Center(child: buildTimer()),
          Spacer(),
          Text('Gửi thông báo khẩn cấp tới tất cả bạn bè',style: TextStyle(
            color: Colors.white,
            fontSize: 10
          ),),
            SizedBox(height: 5,),
            Padding(padding: EdgeInsets.only(left: 10,right: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CupertinoButton(
                  onPressed: ()
                  {
                      Navigator.pop(context);
                  },
                  child: Text("Hủy",style: TextStyle(
                    color: Colors.red
                  ),),
                  color: CupertinoColors.white
              ),
            ),)
          ],
        ),
      ),
    );
  }


  Widget buildTime() {
      return Column(
        children: [
          Spacer(),
          Text('$seconds',style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),),
          SizedBox(
            width: 150,
            child: Divider(color: Colors.white,),
          ),
          Text('Gửi cảnh báo',style:  TextStyle(
    color: Colors.white,
    fontSize: 12
    ),),
          Spacer(),
        ],
      );
  }
  Widget buildTimer(){
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: seconds/10,
            valueColor: AlwaysStoppedAnimation(Colors.white),
            strokeWidth: 12,
            backgroundColor: Colors.white24,
          ),
          Center(child: buildTime(),),
        ],
      ),
    );
  }
}
