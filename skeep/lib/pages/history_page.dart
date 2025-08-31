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

  // List of all transactions
  List<Transaction> itemInventory = [];

  // Filtered + sorted transactions shown in UI
  List<Transaction> displayedTransactions = [];

  @override
  void initState() {
    super.initState();
    loadData(); // Load products from storage
  }

  // Loads products from persistent storage (file/database)
  Future<void> loadData() async {
    final list = await Storage.loadTransactions();
    setState(() {
      itemInventory = list;
      displayedTransactions = List.from(itemInventory); // show all by default
    });
  }

  // Filter history based on search query
  void _filterHistory(String query) {
    final results = itemInventory.where((item) {
      final name = item.name.toLowerCase();
      final supplier = item.supplier.toLowerCase();
      final id = item.id.toLowerCase();

      return name.contains(query.toLowerCase()) ||
          supplier.contains(query.toLowerCase()) ||
          id.contains(query.toLowerCase());
    }).toList();

    setState(() {
      displayedTransactions = results;
    });
  }

  // Sort history by transaction id (ascending/descending)
  void _sortHistory(bool isAscending) {
    setState(() {
      displayedTransactions.sort((a, b) {
        // handle cases like "txn-1" by extracting numbers
        final numA = int.tryParse(a.id.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
        final numB = int.tryParse(b.id.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;

        return isAscending ? numA.compareTo(numB) : numB.compareTo(numA);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        color: const Color(0xFFC4C3F5),
        child: Column(
          children: [
            // Search + Sort
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

            // History List
            Expanded(
              child: ListView.builder(
                itemCount: displayedTransactions.length,
                itemBuilder: (context, index) {
                  final p = displayedTransactions[index];
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

      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 2),
    );
  }
}
