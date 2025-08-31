import 'package:flutter/material.dart';
import 'package:skeep/pages/inventory_page.dart';

class AddProductValidation extends StatelessWidget {
  const AddProductValidation({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Product'),
      content: Text('Are you sure you want to add this product?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InventoryPage()),
            );
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
