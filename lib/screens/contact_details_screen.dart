import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/hive/contacts.dart';
import 'package:task/provider/db_provider.dart';

class ContactDetailsScreen extends StatefulWidget {
  @override
  _ContactDetailsScreenState createState() => _ContactDetailsScreenState();
}

class _ContactDetailsScreenState extends State<ContactDetailsScreen> {
  late Contacts selectedContact;
  late DatabaseProvider databaseProvider;

  @override
  Widget build(BuildContext context) {
    databaseProvider = Provider.of<DatabaseProvider>(context);
    selectedContact = databaseProvider.selectedContact;
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedContact.name),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.chevron_left),
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Name"),
                        Text(selectedContact.name,
                            style: Theme.of(context).textTheme.bodyText1),
                      ]),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Phone"),
                        Text(selectedContact.number,
                            style: Theme.of(context).textTheme.subtitle1),
                      ]),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("country"),
                        Text(selectedContact.country,
                            style: Theme.of(context).textTheme.subtitle1),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
