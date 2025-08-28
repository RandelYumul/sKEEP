import 'package:flutter/material.dart';

class SortWidget extends StatefulWidget {
  final Function(bool isAscending) onSortChange;

  const SortWidget({super.key, required this.onSortChange});

  @override
  State<SortWidget> createState() => _SortWidgetState();
}

class _SortWidgetState extends State<SortWidget> {
  bool isAscending = true; // default sort order

  void _toggleSort() {
    setState(() {
      isAscending = !isAscending;
    });
    widget.onSortChange(isAscending);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _toggleSort,
      icon: AnimatedRotation(
        turns: isAscending ? 0 : 0.5,
        duration: const Duration(milliseconds: 300),
        child: Icon(Icons.swap_vert, color: Colors.grey[700]),
      ),

      // icon: Icon(
      //   isAscending ? Icons.swap_vert : Icons.unfold_more,
      //   color: Colors.grey[700],
      // ),
      tooltip: isAscending ? "Sort Ascending" : "Sort Descending",
    );
  }
}
