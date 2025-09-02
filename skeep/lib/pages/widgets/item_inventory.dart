import 'package:flutter/material.dart';
import 'package:skeep/pages/widgets/item_details.dart';
import 'dart:io';
import '../../entity/product.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../database/storage.dart';
import '../../entity/transaction.dart';

class ItemInventory extends StatefulWidget {
  const ItemInventory({
    super.key,
    required this.product,
    this.productName,
    this.supplier,
    this.price,
    this.unit,
    this.stock,
    this.imagePath,
  });

  final Product product;
  final String? productName;
  final String? supplier;
  final double? price;
  final String? unit;
  final int? stock;
  final String? imagePath;

  @override
  State<ItemInventory> createState() => _ItemInventoryState();
}

class _ItemInventoryState extends State<ItemInventory> {
  // Lists for products & transactions
  List<Product> products = [];
  List<Transaction> transactions = [];

  @override
  void initState() {
    super.initState();
    loadData(); // Load products & transactions from storage
  }

  Future<void> loadData() async {
    final list = await Storage.loadProducts();
    final listT = await Storage.loadTransactions();
    products = list;
    transactions = listT;
  }

  // Deletes a product by name and updates storage
  Future<void> deleteProductByName(String name) async {
    Product product = products.firstWhere((p) => p.name == name);
    Transaction transaction = Transaction(
      id: _nextTransactionId(),
      name: product.name,
      supplier: product.supplier,
      quantityChange: -product.quantity, 
    );

    transactions.add(transaction);
    products.removeWhere((p) => p.name == name);

    await saveProducts();
    await saveTransactions();
    setState(() {
      loadData();
    }); // Refresh UI
  }

  // Generates the next transaction ID based on the current list length
  String _nextTransactionId() {
    final next = transactions.length + 1;
    return '$next';
  }

  // Saves the current products to storage
  Future<void> saveProducts() async => await Storage.saveProducts(products);

  // Saves the current transactions to storage
  Future<void> saveTransactions() async =>
      await Storage.saveTransactions(transactions);

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    if (widget.imagePath != null && widget.imagePath!.isNotEmpty) {
      if (widget.imagePath!.startsWith('lib/assets/')) {
        imageWidget = Image.asset(widget.imagePath!, fit: BoxFit.cover);
      } else {
        imageWidget = Image.file(File(widget.imagePath!), fit: BoxFit.cover);
      }
    } else {
      imageWidget = Image.asset(
        'lib/assets/image_placeholder.png',
        fit: BoxFit.cover,
      );
    }

    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.30,
        children: [
          SlidableAction(
            onPressed: (context) async {
              await deleteProductByName(widget.productName!);
              loadData();
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            borderRadius: BorderRadius.circular(10.0),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Center(
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
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 500),
                      child: Row(
                        children: [
                          // Product Image
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: imageWidget,
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
                                  widget.productName!,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF3B3A3A),
                                  ),
                                ),
                                // Supplier Name
                                Text(
                                  widget.supplier!,
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
                                        "Price: ₱${widget.price}/${widget.unit}",
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
                                      "Stock: ${widget.stock}",
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
                                            product: widget.product,
                                            productName: widget.productName!,
                                            supplier: widget.supplier!,
                                            price: widget.price!,
                                            unit: widget.unit!,
                                            stock: widget.stock!,
                                            imagePath: widget.imagePath!,
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
