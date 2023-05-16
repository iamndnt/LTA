import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:women_safety_app/model/groups.dart';
import 'package:women_safety_app/model/user_model.dart';
import 'package:women_safety_app/widgets/home_widgets/live_safe/location_component/GroupProfile.dart';
import 'package:women_safety_app/widgets/home_widgets/live_safe/location_component/LocationHomeWidget.dart';

class GroupList extends StatefulWidget {
  const GroupList({Key? key}) : super(key: key);

  @override
  _GroupListState createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  @override
  Widget build(BuildContext context) {
    final _grpList = Provider.of<List<Group>>(context);
    return ListView.builder(
        itemCount: _grpList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(_grpList[index].grpName),
              subtitle: TextButton(
                child: Text('Group Info'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          GroupProfile(grp: _grpList[index])));
                },
              ),
              trailing: Container(
                height: 100,
                width: 100,
                child: FutureBuilder(
                  future: _grpList[index].populateUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else {
                      debugPrint('Vao day');
                      List<UserModel> userList = snapshot.data as List<UserModel>;
                      debugPrint('UserList Lenght: ${userList.length}');
                      return IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LocationHomeWidget(
                                    grpDocId: _grpList[index].docId,
                                    grpName: _grpList[index].grpName,
                                    listUsers: userList,
                                  )));
                        },
                      );
                    }
                  },
                ),
              ),
              // trailing: IconButton(
              //   icon: Icon(Icons.arrow_forward),
              //   onPressed: () async {
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => LocationHomeWidget(
              //               grpDocId: _grpList[index].docId,
              //               grpName: _grpList[index].grpName,
              //               listUsers: [],
              //             )));
              //   },
              // ),
              isThreeLine: true,
            ),
          );
        });
  }
}
