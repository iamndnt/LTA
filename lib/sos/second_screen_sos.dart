import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondScreenSOS extends StatefulWidget {
  const SecondScreenSOS({Key? key}) : super(key: key);

  @override
  State<SecondScreenSOS> createState() => _SecondScreenSOSState();
}

class _SecondScreenSOSState extends State<SecondScreenSOS> {

  int seconds=10;
  late Timer timer;
  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    super.initState();
  }

  void startTimer(){
    timer=Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if(seconds!=0)
          seconds--;
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
          Text('Sending emergency alerts to all friends who can see your location',style: TextStyle(
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
                  child: Text("Cancel",style: TextStyle(
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
          Text('Sending Panic Alert',style:  TextStyle(
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
