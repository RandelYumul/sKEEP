import 'package:flutter/material.dart';
import 'package:skeep/pages/widgets/bottom_nav.dart';
import 'package:skeep/pages/widgets/item_history.dart';
import 'package:skeep/pages/widgets/search_bar.dart';
import 'package:skeep/pages/widgets/sort_icon.dart';
import '../entity/product.dart';
import '../entity/transaction.dart';
import '../database/storage.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final TextEditingController _searchController = TextEditingController();
  // List of inventory items 
  List<Transaction> itemInventory = [];

  // List of items currently displayed (filtered/sorted)
  List<Transaction> displayedTransactions = [];

  // Called when the widget is first created
  @override
  void initState() {
    super.initState();
    loadData(); // Load products from storage
    displayedTransactions = List.from(itemInventory); // Initialize displayed items
  }

  // Loads products from persistent storage (file/database)
  Future<void> loadData() async {
    final list = await Storage.loadTransactions(); // Get products from Storage
    setState(() => itemInventory = list); // Update UI with loaded products
  }

  // List of filtered history items
  List<Transaction> filteredHistory = [];

  // Filter history based on search query
  void _filterHistory(String query) {
    final results = itemInventory.where((item) {
      final name = item.name.toString().toLowerCase();
      final supplier = item.supplier.toString().toLowerCase();
      final id = item.id.toString().toLowerCase();
      return name.contains(query.toLowerCase()) || supplier.contains(query.toLowerCase()) || id.contains(query.toLowerCase());
    }).toList();

    setState(() {
      displayedTransactions = results;
    });
  }

  // Sort history by transaction number
  void _sortHistory(bool isAscending) {
    setState(() {
      filteredHistory.sort((a, b) {
        final numA = int.parse(a.id);
        final numB = int.parse(b.id);
        return isAscending ? numA.compareTo(numB) : numB.compareTo(numA);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      filteredHistory = List.from(itemInventory);
    });
    return Scaffold(
      extendBody: true,

      // Content
      body: Container(
        color: const Color(0xFFC4C3F5),
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 32,
                bottom: 16,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CustomSearchBar(
                      controller: _searchController,
                      onChanged: _filterHistory,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SortWidget(onSortChange: _sortHistory),
                ],
              ),
            ),

            // Item History List
            Expanded(
              child: ListView.builder(
                itemCount: filteredHistory.length,
                itemBuilder: (context, index) {
                  final p = filteredHistory[index];
                  return ItemHistory(
                    transactionNum: p.id,
                    productName: p.name,
                    supplier: p.supplier,
                    quantityChange: p.quantityChange,
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 2),
    );
  }
}
