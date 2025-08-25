import 'package:flutter/material.dart';
import 'package:skeep/pages/widgets/bottom_nav.dart';
import 'package:skeep/pages/widgets/item_history.dart';
import 'package:skeep/pages/widgets/search_bar.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final TextEditingController _searchController = TextEditingController();

  // Item History Data
  List<Map<String, dynamic>> itemHistory = [
    {
      'transactionNum': '342',
      'productName': 'Hard Copy A4 Bond Paper',
      'supplier': 'Supplier A',
      'quantityChange': 20,
    },
    {
      'transactionNum': '341',
      'productName': 'Pilot Permanent Marker',
      'supplier': 'Supplier B',
      'quantityChange': -10,
    },
    {
      'transactionNum': '340',
      'productName': 'Victory Yellow Pad Paper',
      'supplier': 'Supplier C',
      'quantityChange': 15,
    },
    {
      'transactionNum': '339',
      'productName': 'Crayons 24pcs',
      'supplier': 'Supplier D',
      'quantityChange': -5,
    },
    {
      'transactionNum': '338',
      'productName': 'Mongol Pencil 12pcs',
      'supplier': 'Supplier E',
      'quantityChange': 30,
    },
    {
      'transactionNum': '337',
      'productName': 'Eraser Large Size',
      'supplier': 'Supplier F',
      'quantityChange': -25,
    },
    {
      'transactionNum': '336',
      'productName': 'Stapler',
      'supplier': 'Supplier G',
      'quantityChange': 12,
    },
    {
      'transactionNum': '335',
      'productName': 'Glue Stick',
      'supplier': 'Supplier H',
      'quantityChange': -8,
    },
    {
      'transactionNum': '334',
      'productName': 'Colored Pencils 12pcs',
      'supplier': 'Supplier I',
      'quantityChange': 18,
    },
    {
      'transactionNum': '333',
      'productName': 'Highlighter Set',
      'supplier': 'Supplier J',
      'quantityChange': -6,
    },
    {
      'transactionNum': '332',
      'productName': 'Whiteboard Markers',
      'supplier': 'Supplier K',
      'quantityChange': 22,
    },
    {
      'transactionNum': '331',
      'productName': 'Notebook A5',
      'supplier': 'Supplier L',
      'quantityChange': -14,
    },
  ];

  List<Map<String, dynamic>> filteredHistory = [];

  @override
  void initState() {
    super.initState();
    filteredHistory = itemHistory; // show all items initially
  }

  void _filterHistory(String query) {
    setState(() {
      filteredHistory = itemHistory.where((item) {
        final productName = item['productName'].toString().toLowerCase();
        final supplier = item['supplier'].toString().toLowerCase();
        final transactionNum = item['transactionNum'].toString().toLowerCase();
        final searchLower = query.toLowerCase();

        return productName.contains(searchLower) ||
            supplier.contains(searchLower) ||
            transactionNum.contains(searchLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
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
              child: CustomSearchBar(
                controller: _searchController,
                onChanged: _filterHistory,
              ),
            ),

            // Item History List
            Expanded(
              child: ListView.builder(
                itemCount: filteredHistory.length,
                itemBuilder: (context, index) {
                  return ItemHistory(
                    transactionNum: filteredHistory[index]['transactionNum'],
                    productName: filteredHistory[index]['productName'],
                    supplier: filteredHistory[index]['supplier'],
                    quantityChange: filteredHistory[index]['quantityChange'],
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
