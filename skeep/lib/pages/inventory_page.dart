import 'package:flutter/material.dart';
import 'package:skeep/pages/widgets/bottom_nav.dart'; // Custom bottom navigation bar widget
import 'package:skeep/pages/widgets/item_inventory.dart'; // Widget to display inventory items
import 'package:skeep/pages/widgets/search_bar.dart'; // Custom search bar widget
import 'package:skeep/pages/widgets/sort_filter_bar.dart'; // Sort/filter bar widget
import '../entity/product.dart';
import '../database/storage.dart';

// Main page for displaying inventory items
class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> { // Show all items when opening the page

  // Index for selected sort/filter option
  int selectedIndex = 0;

  // List of inventory items 
  List<Product> itemInventory = [];

  // Called when the widget is first created
  @override
  void initState() {
    super.initState();
    loadData(); // Load products from storage
    displayedItems = List.from(itemInventory); // Initialize displayed items
  }

  // Loads products from persistent storage (file/database)
  Future<void> loadData() async {
    final list = await Storage.loadProducts(); // Get products from Storage
    setState(() => itemInventory = list); // Update UI with loaded products
  }

  //TO DO: Implement delete product function here and make it slidable


  // List of items currently displayed (filtered/sorted)
  List<Product> displayedItems = [];

  // Controller for the search bar
  TextEditingController searchController = TextEditingController();

  // Filter items based on search query
  void _filterItems(String query) {
    final results = itemInventory.where((item) {
      final name = item.name.toString().toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();

    setState(() {
      displayedItems = results;
    });
  }

  // Show all items (reset filter)
  void _showAll() {
    setState(() {
      displayedItems = List.from(itemInventory);
    });
  }

  // Sort items alphabetically by product name
  void _sortAZ() {
    setState(() {
      displayedItems.sort(
        (a, b) => a.name.compareTo(b.name),
      );
    });
  }

  // Sort items by price (ascending)
  void _sortByPrice() {
    setState(() {
      displayedItems.sort((a, b) => a.price.compareTo(b.price));
    });
  }

  // Handle selection of sort/filter option
  void _onSelect(int index) {
    setState(() {
      selectedIndex = index;

      if (index == 0) {
        _showAll(); // Show all items
      } else if (index == 1) {
        _sortAZ(); // Sort A-Z
      } else if (index == 2) {
        _sortByPrice(); // Sort by price
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _onSelect(selectedIndex);
    });
    // Main UI for inventory page
    return Scaffold(
      extendBody: true,
      body: Container(
        color: const Color(0xFFC4C3F5), 
        child: Column(
          children: [
            const SizedBox(height: 50), // Top spacing

            // Search bar for filtering items
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomSearchBar(
                controller: searchController,
                onChanged: _filterItems,
              ),
            ),

            const SizedBox(height: 16), // Spacing

            // Sort/filter bar for inventory
            SortFilterBar(selectedIndex: selectedIndex, onSelect: _onSelect),

            const SizedBox(height: 16), // Spacing

            // List of inventory items
            Expanded(
              child: ListView.builder(
                itemCount: displayedItems.length,
                itemBuilder: (context, index) {
                  final p = displayedItems[index];
                  return ItemInventory(
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

      // Bottom navigation bar for app navigation
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 1),
    );
    
  }
}