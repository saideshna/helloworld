import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContactListScreen(),
    );
  }
}

class Contact {
  final String name;
  final String phone;

  Contact(this.name, this.phone);
}

class ContactListScreen extends StatelessWidget {
  const ContactListScreen({super.key});

  final List<Contact> contacts = const [
    Contact('John Doe', '123-456-7890'),
    Contact('Jane Smith', '987-654-3210'),
    Contact('Alice Johnson', '555-666-7777'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text(contacts[index].name),
            subtitle: Text(contacts[index].phone),
          );
        },
      ),
    );
  }
}
