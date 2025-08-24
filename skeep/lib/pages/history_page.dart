import 'package:flutter/material.dart';
import 'package:skeep/pages/widgets/bottom_nav.dart';
import 'package:skeep/pages/widgets/item_history.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // Item History Data
  List itemHistory = [
    // Example data
    {'transactionNum': '342', 'productName': 'Hard Copy A4 Bond Paper', 'supplier': 'Supplier A', 'quantityChange': 20},
    {'transactionNum': '341', 'productName': 'Pilot Permanent Marker', 'supplier': 'Supplier B', 'quantityChange': -10},
    {'transactionNum': '340', 'productName': 'Victory Yellow Pad Paper', 'supplier': 'Supplier C', 'quantityChange': 15},
    {'transactionNum': '339', 'productName': 'Crayons 24pcs', 'supplier': 'Supplier D', 'quantityChange': -5},
    {'transactionNum': '338', 'productName': 'Mongol Pencil 12pcs', 'supplier': 'Supplier E', 'quantityChange': 30},
    {'transactionNum': '337', 'productName': 'Eraser Large Size', 'supplier': 'Supplier F', 'quantityChange': -25},
    {'transactionNum': '336', 'productName': 'Stapler', 'supplier': 'Supplier G', 'quantityChange': 12},
    {'transactionNum': '335', 'productName': 'Glue Stick', 'supplier': 'Supplier H', 'quantityChange': -8},
    {'transactionNum': '334', 'productName': 'Colored Pencils 12pcs', 'supplier': 'Supplier I', 'quantityChange': 18},
    {'transactionNum': '333', 'productName': 'Highlighter Set', 'supplier': 'Supplier J', 'quantityChange': -6},
    {'transactionNum': '332', 'productName': 'Whiteboard Markers', 'supplier': 'Supplier K', 'quantityChange': 22},
    {'transactionNum': '331', 'productName': 'Notebook A5', 'supplier': 'Supplier L', 'quantityChange': -14},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      //Content
      body: Container(
        color: Color(0xFFC4C3F5),
        child: Column(
        children: [
          //Search and Sort
          Container(height: 200,),
      
          // Item Inventory List
          Expanded(
            child: ListView.builder(
              itemCount: itemHistory.length,
              itemBuilder: (context, index) {
                return ItemHistory(
                  transactionNum: itemHistory[index]['transactionNum'],
                  productName: itemHistory[index]['productName'],
                  supplier: itemHistory[index]['supplier'],
                  quantityChange: itemHistory[index]['quantityChange'],
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