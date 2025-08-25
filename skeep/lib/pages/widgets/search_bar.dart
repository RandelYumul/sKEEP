import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: "Search...",
              filled: true,
              fillColor: Colors.white,
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Icon(Icons.search, color: Colors.grey[700]),
              ),
              suffixIconConstraints: const BoxConstraints(
                minWidth: 40,
                minHeight: 40,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 20,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
