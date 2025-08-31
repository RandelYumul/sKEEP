import 'package:flutter/material.dart';
import 'package:skeep/pages/widgets/bottom_nav.dart';
import 'package:skeep/pages/widgets/item_inventory.dart';
import 'package:skeep/pages/widgets/search_bar.dart';
import 'package:skeep/pages/widgets/sort_filter_bar.dart';
import '../entity/product.dart';
import '../database/storage.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  int selectedIndex = 0; // current sort/filter option

  // All products loaded from storage
  List<Product> itemInventory = [];

  // Products currently displayed (after search/sort)
  List<Product> displayedItems = [];

  // Search controller
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // Load products from storage
  Future<void> loadData() async {
    final list = await Storage.loadProducts();
    setState(() {
      itemInventory = list;
      displayedItems = List.from(itemInventory); // start with all
    });
  }

  // Filter items by product name or supplier
  void _filterItems(String query) {
    if (query.isEmpty) {
      setState(() {
        displayedItems = List.from(itemInventory);
      });
      return;
    }

    final results = itemInventory.where((item) {
      final name = item.name.toLowerCase();
      final supplier = item.supplier.toLowerCase();
      final q = query.toLowerCase();
      return name.contains(q) || supplier.contains(q);
    }).toList();

    setState(() {
      displayedItems = results;
    });
  }

  // Sort helpers
  void _showAll() {
    setState(() {
      displayedItems = List.from(itemInventory);
    });
  }

  void _sortAZ() {
    setState(() {
      displayedItems.sort((a, b) => a.name.compareTo(b.name));
    });
  }

  void _sortByPrice() {
    setState(() {
      displayedItems.sort((a, b) => a.price.compareTo(b.price));
    });
  }

  // Handle sort/filter bar selection
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

            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomSearchBar(
                controller: searchController,
                onChanged: _filterItems,
              ),
            ),

            const SizedBox(height: 16),

            // Sort/filter bar
            SortFilterBar(
              selectedIndex: selectedIndex,
              onSelect: _onSelect,
            ),

            const SizedBox(height: 16),

            // Inventory list
            Expanded(
              child: ListView.builder(
                itemCount: displayedItems.length,
                itemBuilder: (context, index) {
                  final p = displayedItems[index];
                  return ItemInventory(
                    product: p,
                    productName: p.name,
                    supplier: p.supplier,
                    price: p.price,
                    unit: p.unit,
                    stock: p.quantity,
                    imagePath: p.imagePath,
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Bottom Nav
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 1),
    );
  }
}
