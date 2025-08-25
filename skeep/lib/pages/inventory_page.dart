import 'package:flutter/material.dart';
import 'package:skeep/pages/widgets/bottom_nav.dart';
import 'package:skeep/pages/widgets/item_inventory.dart';
import 'package:skeep/pages/widgets/search_bar.dart';
import 'package:skeep/pages/widgets/sort_filter_bar.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  int selectedIndex = 0;

  List<Map<String, dynamic>> itemInventory = [
    {
      'productName': 'Hard Copy A4 Bond Paper',
      'supplier': 'Supplier A',
      'price': 120.00,
      'unit': 'box',
      'stock': 50,
    },
    {
      'productName': 'Pilot Permanent Marker',
      'supplier': 'Supplier B',
      'price': 80.00,
      'unit': 'set',
      'stock': 30,
    },
    {
      'productName': 'Victory Yellow Pad Paper',
      'supplier': 'Supplier C',
      'price': 150.00,
      'unit': 'pack',
      'stock': 20,
    },
    {
      'productName': 'Crayons 24pcs',
      'supplier': 'Supplier D',
      'price': 60.00,
      'unit': 'box',
      'stock': 100,
    },
    {
      'productName': 'Mongol Pencil 12pcs',
      'supplier': 'Supplier E',
      'price': 40.00,
      'unit': 'set',
      'stock': 75,
    },
    {
      'productName': 'Eraser Large Size',
      'supplier': 'Supplier F',
      'price': 15.00,
      'unit': 'piece',
      'stock': 200,
    },
  ];

  List<Map<String, dynamic>> displayedItems = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayedItems = List.from(itemInventory);
  }

  void _filterItems(String query) {
    final results = itemInventory.where((item) {
      final name = item['productName'].toString().toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();

    setState(() {
      displayedItems = results;
    });
  }

  void _showAll() {
    setState(() {
      displayedItems = List.from(itemInventory);
    });
  }

  void _sortAZ() {
    setState(() {
      displayedItems.sort(
        (a, b) => a['productName'].compareTo(b['productName']),
      );
    });
  }

  void _sortByPrice() {
    setState(() {
      displayedItems.sort((a, b) => a['price'].compareTo(b['price']));
    });
  }

  void _onSelect(int index) {
    setState(() {
      selectedIndex = index;

      if (index == 0) {
        _showAll();
      } else if (index == 1) {
        _sortAZ();
      } else if (index == 2) {
        _sortByPrice();
      }
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
            const SizedBox(height: 50),

            // Reusable Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomSearchBar(
                controller: searchController,
                onChanged: _filterItems,
              ),
            ),

            const SizedBox(height: 16),

            // Reusable Sort/Filter Bar
            SortFilterBar(selectedIndex: selectedIndex, onSelect: _onSelect),

            const SizedBox(height: 16),

            // Item Inventory List
            Expanded(
              child: ListView.builder(
                itemCount: displayedItems.length,
                itemBuilder: (context, index) {
                  return ItemInventory(
                    productName: displayedItems[index]['productName'],
                    supplier: displayedItems[index]['supplier'],
                    price: displayedItems[index]['price'],
                    unit: displayedItems[index]['unit'],
                    stock: displayedItems[index]['stock'],
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 1),
    );
  }
}
