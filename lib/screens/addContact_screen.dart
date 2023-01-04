import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:task/hive/contacts.dart';

class AddContacts extends StatefulWidget {
  @override
  _AddContactsState createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {
  // String _imgURL = '';
  // late String _name;
  // late String _number;
  TextEditingController _name = TextEditingController();
  TextEditingController _number = TextEditingController();
  TextEditingController _country = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "ADD USERS",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _name,
                decoration: InputDecoration(
                  hintText: 'Name',
                ),
                // onChanged: (val) => _name = val,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _number,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Phone number',
                ),
                // onChanged: (val) => _number = val,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _country,
                decoration: InputDecoration(
                  hintText: 'Country',
                ),
                // onChanged: (val) {
                //   setState(() {
                //     _imgURL = val;
                //   });
                // },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final newContact = Contacts(
                      name: _name.text.trim().toString(),
                      number: _number.text.trim().toString(),
                      country: _country.text.trim().toString());
                  _submit(newContact);
                },
                child:
                    const Text('Submit', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit(Contacts contact) {
    print(' url :$_country ,  name: $_name , number: $_number ');
    final contactBox = Hive.box<Contacts>('contacts');
    contactBox.add(contact);
    Navigator.of(context).pop();
  }
}
