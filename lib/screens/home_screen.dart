import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task/hive/contacts.dart';
import 'package:task/provider/db_provider.dart';
import 'package:task/screens/contact_details_screen.dart';
import 'package:task/search_widget.dart';

import 'addContact_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box contactsBox;

  @override
  void initState() {
    super.initState();
    // get the previously opened user box
    contactsBox = Hive.box<Contacts>('contacts');
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchWidget(),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: buildList(context, contactsBox),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddContacts(),
            ),
          );
        },
        elevation: 1.0,
        child: const Icon(Icons.add),
      ),
    );
  }
}

Widget buildList(BuildContext context, Box contactsBox) {
  DatabaseProvider databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);

  return ValueListenableBuilder(
      valueListenable: contactsBox.listenable(),
      builder: (context, contactsBox, _) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: contactsBox.length,
          itemBuilder: (context, index) {
            final contact = contactsBox.getAt(index) as Contacts;
            // with get we can get data from HiveDb, and pass index as 'key'
            return ListTile(
              onTap: () {
                databaseProvider.updateSelectedIndex(index);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ContactDetailsScreen(),
                  ),
                );
              },
              onLongPress: () {
                ///* this will delete that contact from hive
                databaseProvider.updateSelectedIndex(index);
                databaseProvider.deleteFromHive();
              },
              trailing: Text(contact.country),
              title: Text(contact.name,
                  style: Theme.of(context).textTheme.bodyText1),
              subtitle: Text(contact.number,
                  style: Theme.of(context).textTheme.subtitle1),
            );
          },
        );
      });
}
