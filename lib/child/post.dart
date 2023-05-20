
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:women_safety_app/components/AlertPost.dart';

import '../utils/constants.dart';

class Post extends StatefulWidget {
   List<AlertPost> post;
  Post({Key? key,required this.post});
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: widget.post
            .map(
              (eachPost) => GestureDetector(
            onTap: () {
            },
            child: Container(
              height: 180,
              margin: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26.withOpacity(0.1),
                        blurRadius: 8.0,
                        offset: const Offset(5, -5.0),
                        spreadRadius: 0.10),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .snapshots(),
                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

                                  if (!snapshot.hasData) {
                                    return Center(child: progressIndicator(context));
                                  }
                                  for(int i=0;i<snapshot.data!.docs.length;i++){
                                    final d = snapshot.data!.docs[i];
                                    if(eachPost.author_id?.compareTo(d['id'])==0)
                                      return CircleAvatar(
                                        backgroundImage:
                                        NetworkImage(d['profilePic']),
                                        radius: 22,
                                      );
                                  }
                                  return Text('');
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.65,
                                      child: Text(
                                          (eachPost.title?.length ?? 0) > 40 ? "${eachPost.title?.substring(0, 40)}...":"${eachPost.title}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: .4),
                                      ),
                                    ),
                                    const SizedBox(height: 2.0),
                                    Row(
                                      children: <Widget>[
                                        StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection('users')
                                              .snapshots(),
                                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

                                            if (!snapshot.hasData) {
                                              return Center(child: progressIndicator(context));
                                            }
                                            for(int i=0;i<snapshot.data!.docs.length;i++){
                                              final d = snapshot.data!.docs[i];
                                              if(eachPost.author_id?.compareTo(d['id'])==0)
                                                return Text(
                                                  d['name']??'Loading...',
                                                  style: TextStyle(
                                                      color: Colors.grey
                                                          .withOpacity(0.6)),
                                                );
                                            }
                                            return Text('');
                                          },
                                        ),
                                        const SizedBox(width: 16),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      child: Center(
                        child: Text(
                          (eachPost.content?.length ?? 0) > 80
                              ? "${eachPost.content?.substring(0, 80)}.."
                              : "${eachPost.content}",
                          style: TextStyle(
                              color: Colors.grey.withOpacity(0.8),
                              fontSize: 16,
                              letterSpacing: .3),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),

                  ],
                ),
              ),
            ),
          ),
        )
            .toList());
  }

  String parseDateTime(DateTime? date) {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    String created_at;
    if (date != null) {
      created_at = formatter.format(date);
    } else {
      created_at = '01/01/2001';
    }
    return created_at;
  }
}