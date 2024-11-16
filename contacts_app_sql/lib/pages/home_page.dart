import 'package:contacts_app_sql/components/contact_tile.dart';
import 'package:contacts_app_sql/data/database_helper.dart';
import 'package:contacts_app_sql/pages/add_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  List<Contact> contactList = [];

  void updateList() async {
    List<Contact> updatedContacts = await dbHelper.fetchAllContacts();
    setState(() {
      contactList = updatedContacts;
    });
  }

  @override
  void initState() {
    super.initState();
    updateList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text(
            'Contacts',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          elevation: 0,
        ),
        backgroundColor: Colors.deepPurple[200],
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddPage()),
              ).then((value) => updateList());
            },
            child: const Icon(Icons.add)),
        body: SlidableAutoCloseBehavior(
          child: ListView.builder(
              itemCount: contactList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: ContactTile(
                    contactName: contactList[index].name,
                    contactPhone: contactList[index].phone,
                    deleteFunction: (context) {
                      dbHelper.deleteContact(contactList[index].id);
                      Slidable.of(context)?.close();
                      updateList();
                    },
                  ),
                );
              }),
        ));
  }
}
