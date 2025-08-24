import 'package:flutter/material.dart';

class RecentActivities extends StatelessWidget {
  const RecentActivities({super.key, this.productName, this.quantityChange});

  final String? productName;
  final int? quantityChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(left: 16, right: 16, top: 16),
      child: Container(
        // Design
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),

        // Content
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // product name
              Text(
                productName!,
                style: TextStyle(
                  fontSize: 13, 
                  fontWeight: FontWeight.bold
                  ),
              ),
          
              // quantity change
              Text(
                quantityChange! > 0 ? '+$quantityChange' : '$quantityChange',
                style: TextStyle(
                  fontSize: 13,
                  color: quantityChange! > 0 ? Colors.green : Colors.red,
                ),
              )
            ],
          ),
        ),
      ),
      );
  }
}