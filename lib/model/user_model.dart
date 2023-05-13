class UserModel {
  String? name;
  String? id;
  String? phone;
  String? email;
  List<String>? listFriends;
  UserModel(
      {this.name,
      this.id,
      this.phone,
      this.email,
      this.listFriends
      });

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'id': id,
        'email': email,
        'list_friend': listFriends,
      };
}
