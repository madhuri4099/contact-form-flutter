import 'package:flutter/material.dart';
import 'package:flutter_contact_crud/models/contact.dart';
import 'package:flutter_contact_crud/services/contact_service.dart';
import 'add_edit_contact.dart'; // Ensure you import the AddEditContactScreen

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    fetchContacts();
  }

  Future<void> fetchContacts() async {
    contacts = await ContactService().contacts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
            title: Text(contact.name),
            subtitle: Text(contact.phoneNumber),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                ContactService().deleteContact(contact.id!);
                fetchContacts();
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditContactScreen(contact: contact),
                ),
              ).then((_) {
                fetchContacts();
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditContactScreen(),
            ),
          ).then((_) {
            fetchContacts();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
