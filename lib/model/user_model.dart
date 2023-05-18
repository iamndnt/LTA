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
  factory UserModel.fromJson(Map<String, dynamic>? data) {
    final String? idUser = data?['id'];
    final String? name = data?['name'];
    final String? phoneNumber = data?['phone'];
    final String? linkImage = data?['profilePic'];
    final String? email = data?['email'];
    final List<String>? listFriends=[];
    List.from(data?['list_friend']).forEach((element) {
        listFriends?.add(element);
      });

    return UserModel(id: idUser,name: name, phone: phoneNumber,imageUrl: linkImage,email: email,listFriends: listFriends);
  }

  factory UserModel.test() {
    String? id_user = "id_user_test";
    String? name = "name_test";
    String? phoneNumber = "phone_number_test";
    String? linkImage = "link_image_test";
    String? email = "email_test";
    List<String>? listFriends = ["List Test"];
    return UserModel(email: email,id: id_user,name: name,phone: phoneNumber,imageUrl: linkImage,listFriends: listFriends);
  }

  factory UserModel.fromDocumentSnapshot(
    DocumentSnapshot<Map<String,dynamic>> documentSnapshot){
      return UserModel.fromJson(documentSnapshot.data());
    }
  
}
