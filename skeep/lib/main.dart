import 'package:flutter/material.dart';
import 'package:skeep/pages/history_page.dart';
import 'package:skeep/pages/inventory_page.dart';
import 'pages/opening_page.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget{
  MyApp({super.key});

  List pages = [
    const OpeningPage(),
    const InventoryPage(),
    const HistoryPage(),
  ];

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'sKEEP',
      home: const OpeningPage(),
    );
  }
}
