import 'package:flutter/material.dart';
import 'package:women_safety_app/child/post.dart';
import 'package:women_safety_app/components/AlertPost.dart';

class AlertScreen extends StatefulWidget {
  @override
  _AlertScreenState createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {


  @override
  Widget build(BuildContext context) {
    List<AlertPost> _post = AlertPost.getSampleExperiencePostList();
    return  Scaffold(
      body: SafeArea(
          child: Container(
            decoration:  BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
                  Color.fromRGBO(165, 204, 255, 1),
                  Color.fromRGBO(115, 104, 226, 1)
                ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
            child: ListView(
              children: <Widget>[
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
                          "Have a good day!",
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                         SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Share your alert!",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 14.0,
                              ),
                            ),
                               IconButton(
                                onPressed: () {},
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
                            "Alert in your area",
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
            ),
          )),
    );
  }
}
