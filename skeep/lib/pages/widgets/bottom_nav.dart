import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int)? onItemTapped;

  const CustomBottomNavBar({
    super.key, 
    this.selectedIndex = 0,
    this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Color(0xFFF7F5FA),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.home),
                  color: selectedIndex == 0 ? Colors.purple : Colors.grey,
                  iconSize: 30,
                  onPressed: () {
                    if (selectedIndex != 0 && onItemTapped != null) {
                      onItemTapped!(0);
                    }
                  },
                ),
                const Text('Home', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.inventory),
                  color: selectedIndex == 1 ? Colors.purple : Colors.grey,
                  iconSize: 30,
                  onPressed: () {
                    if (selectedIndex != 1 && onItemTapped != null) {
                      onItemTapped!(1);
                    }
                  },
                ),
                const Text('Inventory', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -35),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFF8D47FF),
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xFFF7F5FA), width: 10),
              ),
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                iconSize: 35,
                onPressed: () {
                  // Show a dialog or navigate to add item page
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Add Item'),
                        content: const Text('Add item functionality not implemented yet'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.history),
                  color: selectedIndex == 2 ? Colors.purple : Colors.grey,
                  iconSize: 30,
                  onPressed: () {
                    if (selectedIndex != 2 && onItemTapped != null) {
                      onItemTapped!(2);
                    }
                  },
                ),
                const Text('History', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.person),
                  color: selectedIndex == 3 ? Colors.purple : Colors.grey,
                  iconSize: 30,
                  onPressed: () {
                    if (selectedIndex != 3 && onItemTapped != null) {
                      onItemTapped!(3);
                    }
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
