import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../entity/product.dart';
import '../entity/transaction.dart';
import '../database/storage.dart';
import 'widgets/bottom_nav.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  // Lists for products & transactions
  List<Product> products = [];
  List<Transaction> transactions = [];

  // Controllers for text fields
  final TextEditingController _prodname = TextEditingController();
  final TextEditingController _prodsupp = TextEditingController();
  final TextEditingController _prodprice = TextEditingController();
  final TextEditingController _produnit = TextEditingController();
  final TextEditingController _prodquantity = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();
  final _uuid = Uuid();

  String? imagePath;

  @override
  void initState() {
    super.initState();
    loadData(); // Load products & transactions from storage
  }

  @override
  void dispose() {
    // dispose controllers to avoid memory leaks
    _prodname.dispose();
    _prodsupp.dispose();
    _prodprice.dispose();
    _produnit.dispose();
    _prodquantity.dispose();
    super.dispose();
  }

  Future<void> loadData() async {
    final list = await Storage.loadProducts();
    final listT = await Storage.loadTransactions();
    setState(() {
      products = list;
      transactions = listT;
    });
  }

  Future<void> saveProducts() async => await Storage.saveProducts(products);
  Future<void> saveTransactions() async => await Storage.saveTransactions(transactions);

  Future<void> addProductToList(Product p) async {
    setState(() => products.add(p));
    await saveProducts();
  }

  Future<void> replaceProductAt(int index, Product p) async {
    setState(() => products[index] = p);
    await saveProducts();
  }

  Future<void> addTransactionToList(Transaction t) async {
    setState(() => transactions.add(t));
    await saveTransactions();
  }

  Future<void> _pickImage() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => imagePath = picked.path);
    }
  }

  // returns next transaction id based on current transactions list length
  String _nextTransactionId() {
    final next = transactions.length + 1;
    return '$next';
  }

  int _getQtyChange(String name, int newQuantity) {
    final existingProducts = products.where((p) => p.name == name).toList();
    if (existingProducts.isNotEmpty) {
      return newQuantity - existingProducts.first.quantity;
    } else {
      return newQuantity;
    }
  }

  bool _isExistingProduct(String name) {
    return products.any((p) => p.name == name);
  }

  // Submit handler (used by the inline dialog)
  Future<void> _submit(String savedproname, String savedsupp, double savedprice, String savedunit, int savedquantity) async {
    // Ensure image is chosen
    if (imagePath == null || imagePath!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please choose an image before saving.')));
      return;
    }

    // basic validation
    if (savedproname.isEmpty || savedsupp.isEmpty || savedunit.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill in required fields.')));
      return;
    }

    final productExists = _isExistingProduct(savedproname);

    if (productExists) {
      // Overwrite existing product (keep id)
      final existingIndex = products.indexWhere((p) => p.name == savedproname);
      final existingProduct = products[existingIndex];
      final oldQty = existingProduct.quantity;
      final qtyChange = savedquantity - oldQty;

      final updatedProduct = Product(
        id: existingProduct.id, // preserve id
        name: savedproname,
        supplier: savedsupp,
        unit: savedunit,
        quantity: savedquantity,
        price: savedprice,
        imagePath: imagePath!,
        quantityChange: qtyChange,
      );

      await replaceProductAt(existingIndex, updatedProduct);

      // create transaction for update
      final tx = Transaction(
        id: _nextTransactionId(),
        name: savedproname,
        supplier: savedsupp,
        quantityChange: qtyChange,
      );

      await addTransactionToList(tx);

      loadData();

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product updated and transaction recorded.')));
    } else {
      // create new product
      final product = Product(
        id: _uuid.v4(),
        name: savedproname,
        supplier: savedsupp,
        unit: savedunit,
        quantity: savedquantity,
        price: savedprice,
        imagePath: imagePath!,
        quantityChange: savedquantity,
      );

      await addProductToList(product);

      // create transaction for create
      final tx = Transaction(
        id: _nextTransactionId(),
        name: savedproname,
        supplier: savedsupp,
        quantityChange: savedquantity,
      );

      await addTransactionToList(tx);

      loadData();

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product added and transaction recorded.')));
    }
    
    Navigator.pop(context);
  }

  // Inline confirmation dialog (no external widget)
  Future<void> _showConfirmAndSubmit(String savedproname, String savedsupp, double savedprice, String savedunit, int savedquantity) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Save product?'),
        content: const Text('Are you sure you want to save this product?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Save')),
        ],
      ),
    );

    if (confirmed == true) {
      await _submit(savedproname, savedsupp, savedprice, savedunit, savedquantity);
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
              color: const Color(0xFFFFFFFF),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
                      child: ListView(
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
                                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
                                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
                                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
                                        fontSize: MediaQuery.of(context).size.height * 0.015,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.04,
                                    width: MediaQuery.of(context).size.width * 0.32,
                                    child: TextField(
                                      controller: _produnit,
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.height * 0.015,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Enter unit here...",
                                        hintStyle: TextStyle(
                                          fontSize: MediaQuery.of(context).size.height * 0.015,
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
                                        fontSize: MediaQuery.of(context).size.height * 0.015,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.04,
                                    width: MediaQuery.of(context).size.width * 0.32,
                                    child: TextField(
                                      controller: _prodquantity,
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.height * 0.015,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "0",
                                        hintStyle: TextStyle(
                                          fontSize: MediaQuery.of(context).size.height * 0.015,
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
                              fontSize: MediaQuery.of(context).size.height * 0.015,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // gather values
                            final savedproname = _prodname.text.trim();
                            final savedsupp = _prodsupp.text.trim();
                            final savedprice = double.tryParse(_prodprice.text) ?? 0.0;
                            final savedunit = _produnit.text.trim();
                            final savedquantity = int.tryParse(_prodquantity.text) ?? 0;

                            // quick validation
                            if (savedproname.isEmpty || savedsupp.isEmpty || savedunit.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill required fields.')));
                              return;
                            }

                            // show inline confirm dialog then submit if confirmed
                            _showConfirmAndSubmit(savedproname, savedsupp, savedprice, savedunit, savedquantity);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF634795),
                          ),
                          child: Text(
                            "Save",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height * 0.015,
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
}
