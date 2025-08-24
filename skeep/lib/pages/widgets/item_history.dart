import 'package:flutter/material.dart';

class ItemHistory extends StatelessWidget {
  const ItemHistory({super.key, this.transactionNum, this.productName, this.supplier, this.quantityChange});

  final String? transactionNum;
  final String? productName;
  final String? supplier;
  final int? quantityChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500),
          child: Container(
            // Design
            height: 85,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),

            // Content
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                // Transaction Number
                Text(
                  "#$transactionNum",
                  style: TextStyle(
                    fontSize: 15, 
                    color: Color(0xFF3B3A3A),
                    fontWeight: FontWeight.bold
                    ),
                ),
            
                SizedBox(width: 30), // Add spacing
            
                // Column: Product Name and Supplier
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Product Name
                      Text(
                        productName!,
                        style: TextStyle(
                          fontSize: 16, 
                          color: Color(0xFF3B3A3A),
                          fontWeight: FontWeight.bold
                          ),
                      ),
              
                      // Supplier Name
                      Text(
                        supplier!,
                        style: TextStyle(
                          fontSize: 13, 
                          color: Color(0xFF939393),
                          ),
                      ),
                    ],
                  ),
                ),
            
                // Quantity Change
                Text(
                  quantityChange! > 0 ? '+$quantityChange' : '$quantityChange',
                  style: TextStyle(
                    fontSize: 15,
                    color: quantityChange! > 0 ? Colors.green : Colors.red,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}