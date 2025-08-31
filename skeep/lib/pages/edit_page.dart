import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../entity/product.dart';
import '../entity/transaction.dart';
import '../database/storage.dart';
import 'widgets/bottom_nav.dart';

class EditPage extends StatefulWidget {
  EditPage({super.key, required this.product});
  final Product product;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  // storage data
  List<Product> products = [];
  List<Transaction> transactions = [];

  // form + helpers
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();
  final _uuid = Uuid();

  // controllers
  late final TextEditingController _prodnameController;
  late final TextEditingController _prodsuppController;
  late final TextEditingController _prodpriceController;
  late final TextEditingController _produnitController;
  late final TextEditingController _prodquantityController;

  // image
  String? _imagePath;

  @override
  void initState() {
    super.initState();

    _prodnameController = TextEditingController(text: widget.product.name);
    _prodsuppController = TextEditingController(text: widget.product.supplier);
    _prodpriceController = TextEditingController(text: widget.product.price.toString());
    _produnitController = TextEditingController(text: widget.product.unit);
    _prodquantityController = TextEditingController(text: widget.product.quantity.toString());

    _imagePath = (widget.product.imagePath.isNotEmpty) ? widget.product.imagePath : null;

    loadData();
  }

  @override
  void dispose() {
    _prodnameController.dispose();
    _prodsuppController.dispose();
    _prodpriceController.dispose();
    _produnitController.dispose();
    _prodquantityController.dispose();
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

  /// Persist products list
  Future<void> _saveProducts() async {
    await Storage.saveProducts(products);
  }

  /// Persist transactions list
  Future<void> _saveTransactions() async {
    await Storage.saveTransactions(transactions);
  }

  Future<void> _pickImage() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imagePath = picked.path;
      });
    }
  }

  int _getQtyChangeFromExisting(int oldQty, int newQty) => newQty - oldQty;

  /// Returns next transaction id based on current transactions list length
  String _nextTransactionId() {
    final next = transactions.length + 1;
    return '$next';
  }

  /// MAIN submit handler (async)
  Future<void> _submit() async {
    final savedProname = _prodnameController.text.trim();
    final savedSupp = _prodsuppController.text.trim();
    final savedPrice = double.tryParse(_prodpriceController.text) ?? 0.0;
    final savedUnit = _produnitController.text.trim();
    final savedQuantity = int.tryParse(_prodquantityController.text) ?? 0;
    final imagePath = _imagePath ?? '';

    if (imagePath.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please choose an image before saving.')),
      );
      return;
    }

    // find the product by the ORIGINAL name that was passed to this page
    final originalName = widget.product.name;
    final idx = products.indexWhere((p) => p.name == originalName);

    if (idx >= 0) {
      // updating existing product (preserve existing id)
      final existing = products[idx];
      final oldQty = existing.quantity;
      final qtyChange = _getQtyChangeFromExisting(oldQty, savedQuantity);

      final updated = Product(
        id: existing.id, // PRESERVE id
        name: savedProname,
        supplier: savedSupp,
        unit: savedUnit,
        quantity: savedQuantity,
        price: savedPrice,
        imagePath: imagePath,
        quantityChange: qtyChange,
      );

      // update in list
      setState(() {
        products[idx] = updated;
      });

      // create a transaction record for this update (id based on transactions length)
      final tx = Transaction(
        id: _nextTransactionId(),
        name: savedProname,
        supplier: savedSupp,
        quantityChange: qtyChange,
        // add more fields if your Transaction model has them (timestamp, oldQty, newQty, action, price, etc.)
      );

      setState(() {
        transactions.add(tx);
      });

      // persist both lists
      await _saveProducts();
      await _saveTransactions();

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product updated.')));
    } else {
      // product not found by original name -> treat as new product
      final newP = Product(
        id: _uuid.v4(),
        name: savedProname,
        supplier: savedSupp,
        unit: savedUnit,
        quantity: savedQuantity,
        price: savedPrice,
        imagePath: imagePath,
        quantityChange: savedQuantity,
      );

      final tx = Transaction(
        id: _nextTransactionId(),
        name: savedProname,
        supplier: savedSupp,
        quantityChange: savedQuantity,
      );

      setState(() {
        products.add(newP);
        transactions.add(tx);
      });

      await _saveProducts();
      await _saveTransactions();

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product added.')));
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    if (_imagePath != null && _imagePath!.isNotEmpty) {
      if (_imagePath!.startsWith('lib/assets/')) {
        imageWidget = Image.asset(
          _imagePath!,
          fit: BoxFit.cover,
        );
      } else {
        imageWidget = Image.file(
          File(_imagePath!),
          fit: BoxFit.cover,
        );
      }
    } else {
      imageWidget = Image.asset(
        'lib/assets/image_placeholder.png',
        fit: BoxFit.cover,
      );
    }

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
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Edit Product",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
                            child: _imagePath != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: imageWidget,
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
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          // (UI fields unchanged...)
                          // Product Name
                          Text("Product Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.height * 0.015)),
                          const SizedBox(height: 6),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                            child: TextFormField(
                              controller: _prodnameController,
                              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                              decoration: InputDecoration(
                                hintText: "Enter product name here...",
                                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Supplier
                          Text("Supplier", style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.height * 0.015)),
                          const SizedBox(height: 6),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                            child: TextFormField(
                              controller: _prodsuppController,
                              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                              decoration: InputDecoration(
                                hintText: "Enter supplier here...",
                                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Price
                          Text("Price", style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.height * 0.015)),
                          const SizedBox(height: 6),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                            child: TextFormField(
                              controller: _prodpriceController,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) return 'Required';
                                if (double.tryParse(v) == null) return 'Enter valid number';
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Enter price here...",
                                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Unit & Quantity (row)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Unit
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.32,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Unit", style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.height * 0.015)),
                                    const SizedBox(height: 6),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.04,
                                      child: TextFormField(
                                        controller: _produnitController,
                                        validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                                        decoration: InputDecoration(
                                          hintText: "Enter unit here...",
                                          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                        style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Quantity
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.32,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Quantity", style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.height * 0.015)),
                                    const SizedBox(height: 6),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.04,
                                      child: TextFormField(
                                        controller: _prodquantityController,
                                        keyboardType: TextInputType.number,
                                        validator: (v) {
                                          if (v == null || v.trim().isEmpty) return 'Required';
                                          if (int.tryParse(v) == null) return 'Enter whole number';
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: "0",
                                          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                          filled: true,
                                          fillColor: Colors.white,
                                        ),
                                        style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: MediaQuery.of(context).size.height * 0.015,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (!_formKey.currentState!.validate()) return;
                            final confirmed = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Save changes?'),
                                content: const Text('Are you sure you want to save these changes?'),
                                actions: [
                                  TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
                                  ElevatedButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Save')),
                                ],
                              ),
                            );
                            if (confirmed == true) {
                              await _submit();
                            }
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF634795)),
                          child: Text(
                            "Save",
                            style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015, color: Colors.white),
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
