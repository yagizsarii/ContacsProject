import 'package:contacts_app/data/app_storage.dart';
import 'package:contacts_app/pages/add_page.dart';
import 'package:contacts_app/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() async {
  await AppStorage.appStorageInitilize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const HomePage(),
      routes: {
        '/homepage': (context) => const HomePage(),
        '/addpage': (context) => const AddPage(),
      },
    );
  }
}
