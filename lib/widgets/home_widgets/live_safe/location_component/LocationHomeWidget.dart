import 'package:flutter/material.dart';
import 'package:women_safety_app/model/user_model.dart';
import 'package:women_safety_app/widgets/home_widgets/live_safe/location_component/Maps/map.dart';

class LocationHomeWidget extends StatefulWidget {
  final String grpDocId;
  final String grpName;
  List<UserModel> listUsers;
  LocationHomeWidget({required this.grpDocId,required this.grpName,required this.listUsers, Key? key}) : super(key: key);

  @override
  _LocationHomeWidgetState createState() => _LocationHomeWidgetState();
}

class _LocationHomeWidgetState extends State<LocationHomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.grpName),
      ),
      body: MapScreen(grpDocId: widget.grpDocId,listUsers: widget.listUsers),
    );
  }
}
