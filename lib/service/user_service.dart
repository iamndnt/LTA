import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:women_safety_app/model/user_model.dart';

mixin UserService {
  static const TAG = 'USER_SERVICES';
  FirebaseFirestore _db = FirebaseFirestore.instance;

}
