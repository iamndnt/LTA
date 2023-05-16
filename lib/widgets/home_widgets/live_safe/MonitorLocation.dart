import 'package:flutter/material.dart';
import 'package:women_safety_app/widgets/home_widgets/live_safe/location_component/GroupLocationWidget.dart';

class LocationMonitorCard extends StatelessWidget {
  final Function? onMapFunction;
  const LocationMonitorCard({Key? key, this.onMapFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GroupLocationWidget()),
            );
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                height: 50,
                width: 50,
                child: Center(
                  child: Image.asset(
                    'assets/location-marker.png',
                    height: 32,
                  ),
                ),
              ),
            ),
          ),
          Text('Location Monitor')
        ],
      ),
    );
  }
}
