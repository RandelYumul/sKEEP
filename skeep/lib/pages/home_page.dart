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
              height: MediaQuery.of(context).size.height * 0.82,
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
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      'Inventory Summary',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF311A60),
                      ),
                    ),
                  ),
                  // BOXES AFTER INVENTORY SUMMARY
                  SizedBox(
                    child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //Boxes
                          children: [
                            // 1st Box (top left)
                            Container(
                              constraints: const BoxConstraints(
                                minHeight: 50,
                                maxHeight: 110
                              ),
                              width: MediaQuery.of(context).size.width*0.425,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20)
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsGeometry.all(15),
                                child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                      "145",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.height * 0.035
                                        ),
                                      ),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                      "Total Stock",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.height * 0.02
                                        )
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ),
                            // 2nd Box (top right)
                            Container(
                              constraints: const BoxConstraints(
                                minHeight: 50,
                                maxHeight: 110
                              ),
                              width: MediaQuery.of(context).size.width*0.425,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20)
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsGeometry.all(15),
                                child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                      "8",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.height * 0.035
                                        )
                                      ),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                      "Low Stock",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.height * 0.02
                                        )
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        ),

                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        
                        Padding(
                        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // 3rd Box (bottom left)
                            Container(
                              constraints: const BoxConstraints(
                                minHeight: 50,
                                maxHeight: 110
                              ),
                              width: MediaQuery.of(context).size.width*0.425,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20)
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsGeometry.all(15),
                                child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                      "2",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.height * 0.035
                                        )
                                      ),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                      "No Stock",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.height * 0.02
                                        )
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // 4th Box (bottom right)
                            Container(
                              constraints: const BoxConstraints(
                                minHeight: 50,
                                maxHeight: 110
                              ),
                              width: MediaQuery.of(context).size.width*0.425,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20)
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsGeometry.all(15),
                                child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                      "₱250,255,35",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.height * 0.035
                                        )
                                      ),
                                    ),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                      "Inventory Value",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.height * 0.02
                                        )
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        ),
                      ],
                    ),
                  ),

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
