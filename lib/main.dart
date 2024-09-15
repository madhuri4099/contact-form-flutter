import 'package:flutter/material.dart';
import 'package:flutter_contact_crud/screens/contact_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Contact CRUD',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const ContactListScreen(),
    );
  }
}
