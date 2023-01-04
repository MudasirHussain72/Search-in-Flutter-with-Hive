import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task/screens/contact_details_screen.dart';
import './hive/contacts.dart';
import 'provider/db_provider.dart';

class SearchWidget extends SearchDelegate<Contacts> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          Navigator.pop(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchFinder(
      query: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SearchFinder(
      query: query,
    );
  }
}

class SearchFinder extends StatelessWidget {
  final String query;

  const SearchFinder({required this.query});
  @override
  Widget build(BuildContext context) {
    DatabaseProvider databaseProvider = Provider.of<DatabaseProvider>(context);
    return ValueListenableBuilder(
      valueListenable: Hive.box<Contacts>('contacts').listenable(),
      builder: (context, Box<Contacts> contactsBox, _) {
        ///* this is where we filter data
        var results = query.isEmpty
            ? contactsBox.values.toList() // whole list
            : contactsBox.values
                .where((c) => c.name.toLowerCase().contains(query))
                .toList();

        return results.isEmpty
            ? Center(
                child: Text(
                  'No results found !',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.black,
                      ),
                ),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: results.length,
                itemBuilder: (context, index) {
                  // passing as a custom list
                  final Contacts contactListItem = results[index];

                  return ListTile(
                    onTap: () {
                      ///* This is where we update index so that we could go to that screen
                      var selectedContactIndex =
                          Provider.of<DatabaseProvider>(context, listen: false)
                              .contactsBox
                              .values
                              .toList()
                              .indexOf(results[index]);
                      databaseProvider
                          .updateSelectedIndex(selectedContactIndex);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContactDetailsScreen()));
                    },
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          contactListItem.name,
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          contactListItem.number,
                          textScaleFactor: 1.0,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  );
                },
              );
      },
    );
  }
}
