import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/chat_module/chat_screen.dart';

import '../../utils/constants.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
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
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final d = snapshot.data!.docs[index];
              List<dynamic> listFriend= snapshot.data!.docs[index]['list_friend'];
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
                  // Navigator.push(context, MaterialPa)
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 20 * 0.75),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(d['profilePic']),
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
            },
          );
        },
      ),
    );
  }
}
