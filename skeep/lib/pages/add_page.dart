import 'package:flutter/material.dart';
import 'package:skeep/pages/widgets/add_product_validation.dart';
import 'package:uuid/uuid.dart';
import 'widgets/bottom_nav.dart';
import 'widgets/add_product_validation.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../entity/product.dart';
import '../database/storage.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  // List to hold all products in inventory
  List<Product> products = [];

  // Called when the widget is first created
  @override
  void initState() {
    super.initState();
    loadData(); // Load products from storage
  }

  // Loads products from persistent storage (file/database)
  Future<void> loadData() async {
    final list = await Storage.loadProducts(); // Get products from Storage
    setState(() => products = list); // Update UI with loaded products
  }

  // Saves the current list of products to persistent storage
  Future<void> saveData() async {
    await Storage.saveProducts(products);
  }

  // Adds a new product to the list and saves it
  void addProduct(Product p) {
    setState(() {
      products.add(p); // Add product to list
    });
    saveData(); // Save updated list
  }

  // Deletes a product at the given index and saves changes
  void deleteProduct(int index) {
    setState(() {
      products.removeAt(index); // Remove product from list
    });
    saveData(); // Save updated list
  }

  // Controllers for text fields
  final TextEditingController _prodname = TextEditingController();
  final TextEditingController _prodsupp = TextEditingController();
  final TextEditingController _prodprice = TextEditingController();
  final TextEditingController _produnit = TextEditingController();
  final TextEditingController _prodquantity = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();
  final _uuid = Uuid();
  String savedproname = "";
  String savedsupp = "";
  double savedprice = 0;
  String savedunit = "";
  int savedquantity = 0;
  String? imagePath;

  // Selected image file
  Future<void> _pickImage() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        imagePath = picked.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        color: const Color(0xFFC4C3F5),
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.67,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                
                    // Title
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Add Product",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                
                    // Image Picker
                    Center(
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: imagePath != null
                                ? Image.file(
                                    File(imagePath!),
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )
                                : Icon(
                                    Icons.add_a_photo,
                                    size: 40,
                                    color: Colors.grey[600],
                                  ),
                          ),
                        ),
                      ),
                    ),
                
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    
                    // Product Details Form
                    Expanded(
                      child: 
                        ListView(
                          shrinkWrap: true,
                          children: [
                            // Product Name
                            FittedBox(
                              alignment: Alignment.centerLeft,
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "Product Name",
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height * 0.015,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                            
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                              width: MediaQuery.of(context).size.width * 1,
                              child: TextField(
                                controller: _prodname,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height * 0.015,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  hintText: "Enter product name here...",
                                  hintStyle: TextStyle(
                                    fontSize: MediaQuery.of(context).size.height * 0.015,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 10,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                            
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                            
                            // Supplier
                            FittedBox(
                              alignment: Alignment.centerLeft,
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "Supplier",
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height * 0.015,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                            
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                              width: MediaQuery.of(context).size.width * 1,
                              child: TextField(
                                controller: _prodsupp,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height * 0.015,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  hintText: "Enter supplier here...",
                                  hintStyle: TextStyle(
                                    fontSize: MediaQuery.of(context).size.height * 0.015,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 10,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                            
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                            
                            // Price
                            FittedBox(
                              alignment: Alignment.centerLeft,
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "Price",
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height * 0.015,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                            
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                              width: MediaQuery.of(context).size.width * 1,
                              child: TextField(
                                controller: _prodprice,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height * 0.015,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  hintText: "Enter price here...",
                                  hintStyle: TextStyle(
                                    fontSize: MediaQuery.of(context).size.height * 0.015,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 10,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                            
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                             
                            // Unit and Quantity
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "Unit",
                                        style: TextStyle(
                                          fontSize:
                                              MediaQuery.of(context).size.height * 0.015,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.01,
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.04,
                                      width: MediaQuery.of(context).size.width * 0.32,
                                      child: TextField(
                                        controller: _produnit,
                                        style: TextStyle(
                                          fontSize:
                                              MediaQuery.of(context).size.height * 0.015,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: "Enter unit here...",
                                          hintStyle: TextStyle(
                                            fontSize:
                                                MediaQuery.of(context).size.height *
                                                0.015,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: 10,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "Quantity",
                                        style: TextStyle(
                                          fontSize:
                                              MediaQuery.of(context).size.height * 0.015,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.01,
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.04,
                                      width: MediaQuery.of(context).size.width * 0.32,
                                      child: TextField(
                                        controller: _prodquantity,
                                        style: TextStyle(
                                          fontSize:
                                              MediaQuery.of(context).size.height * 0.015,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: "0",
                                          hintStyle: TextStyle(
                                            fontSize:
                                                MediaQuery.of(context).size.height *
                                                0.015,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: 10,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                          ],
                        ),
                    ),
                
                    // Save and Cancel Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.015,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            savedproname = _prodname.text;
                            savedsupp = _prodsupp.text;
                            savedprice = double.tryParse(_prodprice.text) ?? 0;
                            savedunit = _produnit.text;
                            savedquantity = int.tryParse(_prodquantity.text) ?? 0;
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AddProductValidation(onSave: _submit);
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF634795),
                          ),
                          child: Text(
                            "Save",
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.015,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 1),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate() && imagePath != null) {
      _formKey.currentState!.save();
      final product = Product(
        id: _uuid.v4(),
        name: savedproname,
        supplier: savedsupp,
        unit: savedunit,
        quantity: savedquantity,
        price: savedprice,
        imagePath: imagePath!,
      );
      addProduct(product);
      Navigator.pop(context);
    }    
  } 
}

class AddProductValidation extends StatelessWidget {
  final VoidCallback onSave;
  AddProductValidation({super.key, required this.onSave});

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
          onPressed: onSave,
          child: Text('Save'),
        ),
      ],
    );
  }
}