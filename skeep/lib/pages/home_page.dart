import 'package:flutter/material.dart';
import 'package:skeep/pages/widgets/recent_activities.dart';
import 'widgets/bottom_nav.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  List recentActivities = [
    // Example data
    {'productName': 'Hard Copy A4 Bond Paper', 'quantityChange': -12},
    {'productName': 'Pilot Permanent Marker', 'quantityChange': 15},
    {'productName': 'Victory Yellow Pad Paper', 'quantityChange': 50},
    {'productName': 'Crayons 24pcs', 'quantityChange': 10},
    {'productName': 'Mongol Pencil 12pcs', 'quantityChange': -2},
    {'productName': 'Mongol Pencil 12pcs', 'quantityChange': 10},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Color(0xFFC4C3F5),
          child: Center(
            child: Column(
              children: [
                // Inventory Summary
                Container(
                  padding: EdgeInsets.only(left: 16),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Inventory Summary',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF311A60),
                    ),
                  ),
                ),
                SizedBox(height: 300), //Temporary space for inventory summary
                // Horizontal Line
                SizedBox(height: 60),

                //Recent Activites
                Container(
                  padding: EdgeInsets.only(left: 16),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Recent Activities',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF311A60),
                    ),
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: recentActivities.length,
                    itemBuilder: (context, index) {
                      return RecentActivities(
                        productName: recentActivities[index]['productName'],
                        quantityChange:
                            recentActivities[index]['quantityChange'],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 0),
    );
  }
}
