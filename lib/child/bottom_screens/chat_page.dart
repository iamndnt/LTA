import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/chat_module/chat_screen.dart';

import '../../chat_module/chat_screen_group.dart';
import '../../utils/constants.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  @override
  String avt1="https://firebasestorage.googleapis.com/v0/b/ltsv2-2f7f9.appspot.com/o/profile%2Favatar-mac-dinh.png?alt=media&token=98de0f6e-237c-42ca-93ba-4565e1365eb8";
  String avt2="https://firebasestorage.googleapis.com/v0/b/ltsv2-2f7f9.appspot.com/o/profile%2F148-1489698_the-main-group-group-chat-group-chat-icon.png?alt=media&token=6b74ad58-f925-42d0-9e34-20bfc2e60fe4";

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        // backgroundColor: Color.fromARGB(255, 250, 163, 192),
        title: Text("Chat"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: progressIndicator(context));
          }
           List<Widget> widget= List.generate(snapshot.data!.docs.length, (index) {
            List<dynamic> listFriend= snapshot.data!.docs[index]['list_friend'];
            final d = snapshot.data!.docs[index];
            if(listFriend.contains(FirebaseAuth.instance.currentUser!.uid))
              return InkWell(
                onTap: () {
                  goTo(
                      context,
                      ChatScreen1v1(
                          currentUserId:
                          FirebaseAuth.instance.currentUser!.uid,
                          friendId: d.id,
                          friendName: d['name']));

                  print('object is oke');
                  // Navigator.push(context, MaterialPa)
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5, vertical: 5),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(snapshot.data!.docs.contains('profilePic')?avt1:d['profilePic']),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              height: 16,
                              width: 16,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    width: 3),
                              ),
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                d['name'],
                                style:
                                TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 8),
                              Opacity(
                                opacity: 0.64,
                                child: Text(
                                  'Chat with '+d['name']+' now!',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            return Text('');
          });
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('groups')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot1) {
                if (!snapshot1.hasData) {
                  return Center(child: progressIndicator(context));
                }
                List<Widget> widget2= List.generate(snapshot1.data!.docs.length, (index) {
                  final g = snapshot1.data!.docs[index];
                  List<dynamic> listMemeber= snapshot1.data!.docs[index]['userUidList'];
                  if(listMemeber.contains(FirebaseAuth.instance.currentUser!.uid) )
                    return InkWell(
                      onTap: () {
                        var array=g['userUidList'];
                        List<String> strings = List<String>.from(array);
                        goTo(
                            context,
                            ChatScreenGroup(
                                currentUserId: FirebaseAuth.instance.currentUser!.uid,
                                groupId: g['docId'],
                                friendsId: strings,
                                groupName: g['grpName']));
                        print('object is not oke');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundImage: NetworkImage(snapshot1.data!.docs.contains('profilePic')?g['groupPic']:avt2),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    height: 16,
                                    width: 16,
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Theme.of(context).scaffoldBackgroundColor,
                                          width: 3),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      g['grpName'],
                                      style:
                                      TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(height: 8),
                                    Opacity(
                                      opacity: 0.64,
                                      child: Text(
                                        'Chat with group: '+g['grpName']+' now!',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  return Text('');
                });
                
                for(int i=0; i<widget.length;i++){
                  widget2.add(widget[i]);
                }
                return ListView.builder(
                    itemCount: widget2.length,
                    itemBuilder: (BuildContext context, int index){
                        return widget2[index];
                    });
              });

        },
      ),
    );
  }
}
