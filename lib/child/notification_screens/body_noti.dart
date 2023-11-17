import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_app/model/user_model.dart';

import '../../service/database_service.dart';

// ignore: must_be_immutable
class BodyNoti extends StatefulWidget {
  BodyNoti({
    Key? key,
  }) : super(key: key);

  @override
  State<BodyNoti> createState() => _BodyNotiState();
}

FirebaseAuth _auth = FirebaseAuth.instance;
String currentId = _auth.currentUser!.uid;

class _BodyNotiState extends State<BodyNoti> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: DatabaseService().getListIdSender(currentId),
        builder: (BuildContext context, AsyncSnapshot<List<String>?> snapshot) {
          List<String>? listIdSender = snapshot.data;
          return Text("Danh sách id người gửi ${listIdSender?.length}");

          //   ListView.builder(
          //   itemCount: listSOS.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     MyUser user = list_user[0];
          //     for(int i=0;i<list_user.length;i++)
          //       if(listSOS[index].id_sender == list_user[i].id_user){
          //         user = list_user[i];
          //         break;
          //       }

          //     return Padding(
          //       padding: const EdgeInsets.symmetric(vertical: 0.0),
          //       child: ListTile(
          //         leading: CircleAvatar(
          //           backgroundImage: NetworkImage(
          //               user.linkImage!),
          //         ),
          //         title: Text(user.name! + " needs your help!"),
          //         subtitle: daysBetween(DateTime.now(), listSOS[index].created_at!) == 0? Text('Today'):Text(daysBetween(DateTime.now(), listSOS[index].created_at!).toString() + 'days ago'),
          //         trailing: Icon(Icons.more_horiz),
          //       ),
          //     );
          //   },
          // ),
        });
  }
}
