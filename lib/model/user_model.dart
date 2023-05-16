import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
FirebaseAuth _auth = FirebaseAuth.instance;

class UserModel {
  String? name;
  String? id;
  String? phone;
  String? email;
  String? imageUrl;
  List<String>? listFriends;

  Future<Map<String,String>> getIdAndImageUser() async {
    Map<String,String> mapResult = new Map();

    

    return mapResult;
  }

  Future addUser() async {
    assert(_auth.currentUser != null);
    String id = _auth.currentUser!.uid;
    String? name = _auth.currentUser!.displayName;
    String? imageUrl = _auth.currentUser!.photoURL;
    imageUrl ??= this.imageUrl;
    name ??= this.name;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    DocumentSnapshot documentSnapshot = await users.doc(id).get();
    if (!documentSnapshot.exists) {
      try {
        await users.doc(id).set({
          'id': id,
          'name': name,
          'profilePic': imageUrl,
        },SetOptions(merge: true));
        // print("user added to databse");
      } catch (e) {
        // for if some error occured
        print(e);
      }
    }
  }
  UserModel(
      {this.name,
      this.id,
      this.phone,
      this.email,
      this.imageUrl,
      this.listFriends
      });

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'id': id,
        'email': email,
        'profilePic': imageUrl,
        'list_friend': listFriends,
      };
}
