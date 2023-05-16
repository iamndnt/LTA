import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

import 'package:women_safety_app/model/user_model.dart';


class UserService {
  static const TAG = 'USER_SERVICES';
  FirebaseFirestore _db = FirebaseFirestore.instance;

  List<UserModel>? _usersFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    return querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        return UserModel.fromDocumentSnapshot(documentSnapshot);
      }
      return UserModel.test();
    }).toList();
  }

  Future<List<UserModel>?> get allUsersOnce {
    return _db.collection('users').get().then(_usersFromQuerySnapshot);
  }

  Future<String> nameOfUser(String? idUser) async {
    List<UserModel>? temp = await allUsersOnce;
    String name='';
    for (int i = 0; i < (temp?.length ?? 0); i++) {
      if ( (temp?[i].id ?? TAG).compareTo(idUser ?? '') == 0) {
        name = temp?[i].id ?? TAG;
        break;
      }
    }
    return name;
  }

  // Future<List<String>?> getAllFriendsId(String idMyUser) async {
    
  //   List<String>? listIdFriends=[];
  //   var docRef = await _db.collection('users').doc(idMyUser).get().then((value) {
  //    final data = value.data();
  //    debugPrint('data: ${data.toString()}');
     
  //    List.from(data?['listFriends']).forEach((element) {
  //     listIdFriends.add(element);
  //    });
  //     return  listIdFriends ;
  //   });

  //   debugPrint('KAKAKAK ${listIdFriends.length}');

  //   return listIdFriends.toList() ;
  // }


  // Future<String?> getUser(String? idUser) async {
  //   List<MyUser>? temp = await allUsersOnce as List<MyUser>?;
  //   for (int i = 0; i < (temp?.length ?? 0); i++) {
  //     if (temp?[i].getIdMyUser.compareTo(idUser ?? '') == 0) {
  //       return temp?[i].id_user;
  //     }
  //   }
  //   return '';
  // }

  // Future<bool> checkPhoneHasExist(String? phone) async {
  //   List<MyUser>? temp = await allUsersOnce as List<MyUser>?;
  //   for (int i = 0; i < (temp?.length ?? 0); i++) {
  //     if ( (temp?[i].phoneNumber ?? TAG).compareTo(phone ?? '') == 0) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }


  // void addUser(MyUser user) async {
  //   DocumentReference doc = _db.collection('users').doc();

  //   String doc_id = doc.id;
  //   if (user.id_user == null) {
  //       user.id_user=doc_id;
  //   } 

  //   CollectionReference subcollection =
  //   _db.collection('users').doc(user.id_user).collection('location');

  //   // Add Location to firebase
  //   var position = await Geolocator.getCurrentPosition();
   
  //   DocumentReference docRef =
  //   _db.collection('users').doc(user.id_user).collection('location').doc();
  //   doc
  //       .set(user.toJson())
  //       .then((value) => print('User added successfully'))
  //       .catchError((error) => print('Failed to add an User'));


  //   user.location?.idLocation ??= docRef.id;
  //   Location l=Location(user.location?.idLocation,position.altitude.toString(), position.longitude.toString());
  //   docRef.set(l.toJson()).then((_) {
  //     debugPrint(
  //         'New location is added to Users ${user.id_user}\n with id ${docRef.id}');
  //   // ignore: invalid_return_type_for_catch_error
  //   }).catchError((onError) => debugPrint('Failed to add an User with errod ${onError.toString()}'));
  //   // Add experiencePost to firebase
  //   // doc.set(user.toJson()).then((value) {
  //   //   doc.firestore.doc(doc_id).collection('location').add(
  //   //       {'latitude': position.altitude, 'longitude': position.longitude});
  //   //   print('Experience added successfully');
  //   // }).catchError((error) => print('Failed to add an experiencePost'));

  //   //subcollection.add(Location(position.altitude.toString(), position.longitude.toString()).toJson());

  // // subcollection.add(Location(user.location?.idLocation,position.altitude.toString(), position.longitude.toString()).toJson());

  //   // doc
  //   //     .set(user.toJson())
  //   //     .then((value) => print('User added successfully'))
  //   //     .catchError((error) => print('Failed to add an User'));
  // }
}