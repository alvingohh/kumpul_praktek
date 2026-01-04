import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class EditContact extends StatefulWidget {
  final Contact contact;
  const EditContact({super.key, required this.contact});

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  late TextEditingController namaDepan;
  late TextEditingController namaBelakang;
  late TextEditingController nomor;

  editContact() async {
    widget.contact.name.first = namaDepan.text;
    widget.contact.name.last = namaBelakang.text;
    widget.contact.phones.first.number = nomor.text;
    await widget.contact.update();
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    namaDepan = TextEditingController(text: widget.contact.name.first);
    namaBelakang = TextEditingController(text: widget.contact.name.last);
    nomor = TextEditingController(text: widget.contact.phones.first.number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Contact"),
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
              onPressed: editContact,
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
