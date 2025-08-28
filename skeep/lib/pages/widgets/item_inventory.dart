import 'package:flutter/material.dart';
import 'package:skeep/pages/widgets/item_details.dart';

class ItemInventory extends StatelessWidget {
  const ItemInventory({
    super.key,
    this.productName,
    this.supplier,
    this.price,
    this.unit,
    this.stock,
  });

  final String? productName;
  final String? supplier;
  final double? price;
  final String? unit;
  final int? stock;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 400), // Increased max width
          child: Container(
            // Design
            height: 135,
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
                  Expanded(
                    child: Row(
                      children: [
                        // Product Image
                        Container(
                          width: 80, // Reduced width
                          height: 80, // Reduced height
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Icon(
                            Icons.image,
                            size: 30, // Reduced icon size
                            color: Colors.grey[600],
                          ),
                        ),

                        SizedBox(width: 12), // Add spacing
                        //Product Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //Product Name
                              Text(
                                productName!,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF3B3A3A),
                                ),
                              ),
                              // Supplier Name
                              Text(
                                supplier!,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF939393),
                                ),
                              ),

                              // Price and Stock
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Price
                                  Flexible(
                                    child: Text(
                                      "Price: ₱$price/$unit",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  // Stock
                                  Text(
                                    "Stock: $stock",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 6), // Reduced spacing
                              //Button
                              SizedBox(
                                height: 28, // Fixed button height
                                width: double
                                    .infinity, // Take full width of the column
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Go to item deatails page
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ItemDetails(
                                          productName: productName!,
                                          supplier: supplier!,
                                          price: price!,
                                          unit: unit!,
                                          stock: stock!,
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(
                                      0xFF634795,
                                    ), // Button color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        10.0,
                                      ), // Rounded corners
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ), // Reduced padding
                                  ),
                                  child: Text(
                                    'Item Details',
                                    style: TextStyle(
                                      color: Colors.white, // Text color
                                      fontSize: 11, // Reduced font size
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
