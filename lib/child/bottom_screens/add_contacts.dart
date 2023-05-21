import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';
import 'package:women_safety_app/child/bottom_screens/add_friend.dart';
import 'package:women_safety_app/child/bottom_screens/contacts_page.dart';
import 'package:women_safety_app/components/PrimaryButton.dart';
import 'package:women_safety_app/db/db_services.dart';
import 'package:women_safety_app/db/user_model_services.dart';
import 'package:women_safety_app/model/contactsm.dart';
import 'package:women_safety_app/model/user_model.dart';

class AddContactsPage extends StatefulWidget {
  const AddContactsPage({super.key});

  @override
  State<AddContactsPage> createState() => _AddContactsPageState();
}

class _AddContactsPageState extends State<AddContactsPage> {
  DatabaseHelper databasehelper = DatabaseHelper();
  List<TContact>? contactList;
  int count = 0;

  late Future<List<UserModel>?> _listUserFromFireStore;

  void showList() {
    Future<Database> dbFuture = databasehelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<TContact>> contactListFuture =
          databasehelper.getContactList();
      contactListFuture.then((value) {
        setState(() {
          this.contactList = value;
          this.count = value.length;
        });
      });
    });
  }

  void deleteContact(TContact contact) async {
    int result = await databasehelper.deleteContact(contact.id);
    if (result != 0) {
      Fluttertoast.showToast(msg: "contact removed succesfully");
      showList();
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showList();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (contactList == null) {
      contactList = [];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    child: PrimaryButton(
                        title: "Add Friends",
                        onPressed: () async {
                          UserService userService = UserService();
                          var listUsers = (await userService.allUsersOnce);

                          debugPrint(
                              'Length of List User: ${listUsers?.length}');
                          listUsers?.forEach(
                            (element) {
                              debugPrint('User: ${element.phone}');
                            },
                          );

                          bool result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddFriend(
                                    listUserFromFireStore: listUsers ?? []),
                              ));
                          if (result == true) {
                            showList();
                          }
                        }),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    width: 170,
                    child: PrimaryButton(
                        title: "Add Contacts",
                        onPressed: () async {
                          bool result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContactsPage(),
                              ));
                          if (result == true) {
                            showList();
                          }
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Expanded(
                child: ListView.builder(
                  // shrinkWrap: true,
                  itemCount: count,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(contactList![index].name),
                          trailing: Container(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      await FlutterPhoneDirectCaller.callNumber(
                                          contactList![index].number);
                                    },
                                    icon: Icon(
                                      Icons.call,
                                      color: Colors.red,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      deleteContact(contactList![index]);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
