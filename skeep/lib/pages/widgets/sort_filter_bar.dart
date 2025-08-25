import 'package:flutter/material.dart';

class SortFilterBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onSelect;

  const SortFilterBar({
    super.key,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => onSelect(0),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedIndex == 0
                        ? const Color(0xFF634795)
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "All",
                    style: TextStyle(
                      color: selectedIndex == 0 ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => onSelect(1),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedIndex == 1
                        ? const Color(0xFF634795)
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Sort A-Z",
                    style: TextStyle(
                      color: selectedIndex == 1 ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => onSelect(2),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedIndex == 2
                        ? const Color(0xFF634795)
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Sort by Price",
                    style: TextStyle(
                      fontSize: 12.6,
                      color: selectedIndex == 2 ? Colors.white : Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
