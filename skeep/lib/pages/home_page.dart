import 'package:flutter/material.dart';
import 'package:skeep/pages/widgets/recent_activities.dart';
import 'widgets/bottom_nav.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key, required this.username});

  final String username;

  final List recentActivities = [
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Text("Hello, $username!",
              style: TextStyle(
                color: Color(0xFFFFF5F5),
                fontSize: MediaQuery.of(context).size.height * 0.05),
                textAlign: TextAlign.left,
                ),
              ),
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFC4C3F5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  // Inventory Summary
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      'Inventory Summary',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF311A60),
                      ),
                    ),
                  ),
                  const SizedBox(height: 200), // temporary space

                  // Recent Activities
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      'Recent Activities',
                      style: const TextStyle(
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
                          quantityChange: recentActivities[index]['quantityChange'],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 0),
    );
  }
}
