import 'package:flutter/material.dart';
import 'package:kumpul_praktek/M10/add_contact.dart';
import 'package:kumpul_praktek/M10/edit_contact.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ListContact extends StatefulWidget {
  const ListContact({super.key});

  @override
  State<ListContact> createState() => _ListContactState();
}

class _ListContactState extends State<ListContact> {
  Widget? screen;
  bool allowAdd = true;

  buildListContacts() async {
    List<Contact> contactsFind = await FlutterContacts.getContacts(
      withProperties: true,
      withPhoto: true,
      withAccounts: true,
    );

    final contacts = contactsFind.where((c) => c.phones.isNotEmpty).toList();

    if (contacts.isNotEmpty) {
      screen = ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (_, index) {
          String nama =
              "${contacts[index].name.first} ${contacts[index].name.last}";
          String nomor = contacts[index].phones.first.number;

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              child: Icon(Icons.person),
            ),
            title: Text(nama),
            subtitle: Text(nomor),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 4,
              children: [
                IconButton(
                  onPressed: () {
                    print("Menekan Edit");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditContact(contact: contacts[index]),
                      ),
                    );
                  },
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () async {
                    await contacts[index].delete();
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          );
        },
      );
    } else {
      screen = Center(child: Text("Kontak kosong"));
    }

    setState(() {});
  }

  checkPermission() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      FlutterContacts.addListener(() {
        print("Database berubah");
        buildListContacts();
      });
      buildListContacts();
    } else if (status.isDenied) {
      status = await Permission.contacts.request();
      if (status.isGranted) {
        FlutterContacts.addListener(() {
          print("Database berubah");
          buildListContacts();
        });
        buildListContacts();
      } else {
        setState(() {
          screen = Center(child: Text("Perlu Izin"));
        });
      }
    }
  }

  initialScreen() {
    checkPermission();
    return screen;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              openAppSettings();
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),

      body: screen ?? initialScreen(),
      // FutureBuilder(
      //   future: checkPermission(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return SizedBox();
      //     }
      //     return screen;
      //   },
      // ),
      floatingActionButton: allowAdd
          ? FloatingActionButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddContact()),
                );
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
