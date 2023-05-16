import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:women_safety_app/chat_module/message_text_field.dart';
import 'package:women_safety_app/chat_module/message_text_field_gr.dart';
import 'package:women_safety_app/chat_module/singleMessage.dart';
import '../utils/constants.dart';
class ChatScreenGroup extends StatefulWidget {
  final String currentUserId;
  final String groupId;
  final List<String>? friendsId;
  final String groupName;

  const ChatScreenGroup(
      {super.key,
        required this.currentUserId,
        required this.groupId,
        required this.friendsId,
        required this.groupName});

  @override
  State<ChatScreenGroup> createState() => _ChatScreenGroupState();
}

class _ChatScreenGroupState extends State<ChatScreenGroup> {
  String? type;
  String? myname;

  getStatus() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.currentUserId)
        .get()
        .then((value) {
      setState(() {
        type = value.data()!['type'];

        myname = value.data()!['name'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text(widget.groupName),
        ),
        body: Column(
          children: [
        Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('groups')
                    .doc(widget.groupId)
                    .collection('chats')
                    .orderBy('date', descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.length < 1) {
                      return Center(
                        child: Text(
                          'Let start conversation with '+widget.groupName,
                          style: TextStyle(fontSize: 30),
                        ),
                      );
                    }

                    return Container(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          bool isMe = snapshot.data!.docs[index]['senderId'] ==
                              widget.currentUserId;
                          final data = snapshot.data!.docs[index];
                          return Dismissible(
                            key: UniqueKey(),
                            onDismissed: (direction) async {
                              await FirebaseFirestore.instance
                                  .collection('groups')
                                  .doc(widget.groupId)
                                  .collection('chats')
                                  .doc(data.id)
                                  .delete();
                              await FirebaseFirestore.instance
                                  .collection('groups')
                                  .doc(widget.groupId)
                                  .collection('chats')
                                  .doc(data.id)
                                  .delete()
                                  .then((value) => Fluttertoast.showToast(
                                  msg: 'message deleted successfully'));
                            },
                            child: SingleMessage(
                              message: data['message'],
                              date: data['date'],
                              isMe: isMe,
                              friendName: snapshot.data!.docs[index]['senderId'],
                              myName: myname,
                              type: data['type'],
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return progressIndicator(context);
                },
              ),
            ),
            MessageTextFieldGroup(
              currentId: widget.currentUserId,
              groupId: widget.groupId,
            ),
          ],
        ),
    );

  }
}
