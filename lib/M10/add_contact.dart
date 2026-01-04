import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  TextEditingController namaDepan = TextEditingController();
  TextEditingController namaBelakang = TextEditingController();
  TextEditingController nomor = TextEditingController();

  saveContact() async {
    final newContact = Contact()
      ..name.first = namaDepan.text
      ..name.last = namaBelakang.text
      ..phones = [Phone(nomor.text)];
    await newContact.insert();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Contact"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 24,
          children: [
            SizedBox(
              height: 56,
              child: TextField(
                controller: namaDepan,
                decoration: InputDecoration(hintText: "Nama Depan"),
              ),
            ),
            SizedBox(
              height: 56,
              child: TextField(
                controller: namaBelakang,
                decoration: InputDecoration(hintText: "Nama Belakang"),
              ),
            ),
            SizedBox(
              height: 56,
              child: TextField(
                controller: nomor,
                decoration: InputDecoration(hintText: "Nomor Kontak"),
              ),
            ),
            TextButton(
              onPressed: saveContact,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),

              child: Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
