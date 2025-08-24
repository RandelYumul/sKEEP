import 'package:flutter/material.dart';
import 'package:skeep/pages/widgets/bottom_nav.dart';
import 'package:skeep/pages/widgets/item_inventory.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  List itemInventory = [
    // Example data
    {'productName': 'Hard Copy A4 Bond Paper', 'supplier': 'Supplier A', 'price': 120.00, 'unit': 'box', 'stock': 50},
    {'productName': 'Pilot Permanent Marker', 'supplier': 'Supplier B', 'price': 80.00, 'unit': 'set', 'stock': 30},
    {'productName': 'Victory Yellow Pad Paper', 'supplier': 'Supplier C', 'price': 150.00, 'unit': 'pack', 'stock': 20},
    {'productName': 'Crayons 24pcs', 'supplier': 'Supplier D', 'price': 60.00, 'unit': 'box', 'stock': 100},
    {'productName': 'Mongol Pencil 12pcs', 'supplier': 'Supplier E', 'price': 40.00, 'unit': 'set', 'stock': 75},
    {'productName': 'Eraser Large Size', 'supplier': 'Supplier F', 'price': 15.00, 'unit': 'piece', 'stock': 200},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      //Content
      body: Container(
        color: Color(0xFFC4C3F5),
        child:Column(
        children: [
          //Search and Sort
          Container(height: 200,),
      
          // Item Inventory List
          Expanded(
            child: ListView.builder(
              itemCount: itemInventory.length,
              itemBuilder: (context, index) {
                return ItemInventory(
                  productName: itemInventory[index]['productName'],
                  supplier: itemInventory[index]['supplier'],
                  price: itemInventory[index]['price'],
                  unit: itemInventory[index]['unit'],
                  stock: itemInventory[index]['stock'],
                );
              },
            ),
          ),
        ],
      )
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 1),
    );
  }
}