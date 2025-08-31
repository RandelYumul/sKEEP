import 'package:flutter/material.dart';
import 'package:skeep/pages/history_page.dart';
import 'package:skeep/pages/inventory_page.dart';
import 'pages/opening_page.dart';
import 'pages/profile_page.dart';
import 'entity/product.dart';
import 'database/storage.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget{
  MyApp({super.key});

  List pages = [
    const OpeningPage(),
    const InventoryPage(),
    const HistoryPage(),
    const ProfilePage()
  ];

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // List to hold all products in inventory
  List<Product> products = [];

  // Called when the widget is first created
  @override
  void initState() {
    super.initState();
    loadData(); // Load products from storage
  }

  // Loads products from persistent storage (file/database)
  Future<void> loadData() async {
    final list = await Storage.loadProducts(); // Get products from Storage
    setState(() => products = list); // Update UI with loaded products
  }

  // Saves the current list of products to persistent storage
  Future<void> saveData() async {
    await Storage.saveProducts(products);
  }

  // Adds a new product to the list and saves it
  void addProduct(Product p) {
    setState(() {
      products.add(p); // Add product to list
    });
    saveData(); // Save updated list
  }

  // Deletes a product at the given index and saves changes
  void deleteProduct(int index) {
    setState(() {
      products.removeAt(index); // Remove product from list
    });
    saveData(); // Save updated list
  }
  
  // MAIN UI FOR THE APP
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'sKEEP',
      home: const OpeningPage(),
    );
  }
}
