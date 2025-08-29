import 'package:flutter/material.dart';
import 'package:skeep/pages/add_page.dart';
import '../profile_page.dart';
import '../home_page.dart';
import '../login_page.dart';
import '../inventory_page.dart';
import '../history_page.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final String? username;

  const CustomBottomNavBar({
    super.key,
    this.selectedIndex = 0,
    this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F5FA),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Home
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.home),
                  color: selectedIndex == 0 ? Colors.purple : Colors.grey,
                  iconSize: 30,
                  onPressed: () {
                    if (username != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(username: username!),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(username: "Guest"),
                        ),
                      );
                    }
                  },
                ),
                const Text('Home', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),

          // Inventory
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.inventory),
                  color: selectedIndex == 1 ? Colors.purple : Colors.grey,
                  iconSize: 30,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InventoryPage()),
                    );
                  },
                ),
                const Text('Inventory', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),

          // Center Add Button
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -35),
              child: Container(
                width: 80, 
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFF8D47FF),
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xFFF7F5FA), width: 10),
                ),
                child: IconButton(
                  icon: const Icon(Icons.add, color: Colors.white),
                  iconSize: 35,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddPage()),
                    );
                  },
                ),
              ),
            ),
          ),

          // History
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.history),
                  color: selectedIndex == 2 ? Colors.purple : Colors.grey,
                  iconSize: 30,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HistoryPage()),
                    );
                  },
                ),
                const Text('History', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),

          // Profile
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.person),
                  color: selectedIndex == 3 ? Colors.purple : Colors.grey,
                  iconSize: 30,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                ),
                const Text('Profile', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
