import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:women_safety_app/db/auth_services.dart';
import 'package:women_safety_app/db/group_services.dart';
import 'package:women_safety_app/model/groups.dart';
import 'package:women_safety_app/widgets/home_widgets/live_safe/location_component/GroupList.dart';


class GroupLocationWidget extends StatefulWidget {
  const GroupLocationWidget({Key? key}) : super(key: key);

  @override
  _GroupLocationWidgetState createState() => _GroupLocationWidgetState();
}

class _GroupLocationWidgetState extends State<GroupLocationWidget> {
  AuthClass authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    // return StreamProvider<List<Group>>.value(
    //   initialData: [],
    //   value: GroupService().groups,
    //   child: Scaffold(
    //     floatingActionButton: FloatingActionButton(
    //       onPressed: () {
    //          Navigator.push(
    //           context,
    //           MaterialPageRoute(builder: (context) => const GroupList()),
    //         );
    //       },
    //       child: Icon(Icons.add),
    //     ),
    //     appBar: AppBar(
    //       title: Text('My GroupLocationWidget'),
    //     ),
    //     body: Builder(
    //       builder: (context) {
    //         return GroupList();
    //       }
    //     ),
    //   ),
    // );
    return StreamProvider<List<Group>>.value(
      initialData: [],
      value: GroupService().groups,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/search');
            //  Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const GroupList()),
            // );
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text('My GroupLocationWidget'),
        ),
        body: Builder(
          builder: (context) {
            return GroupList();
          }
        ),
      ),
    );
   }
}
