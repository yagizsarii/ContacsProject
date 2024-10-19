import 'package:contacts_app/pages/add_page.dart';
import 'package:contacts_app/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      home: HomePage(),
      routes: {
        '/homepage': (context) => HomePage(),
        '/addpage': (context) => AddPage(),
      },
    );
  }
}