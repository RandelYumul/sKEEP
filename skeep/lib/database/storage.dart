import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../entity/product.dart';
import '../entity/transaction.dart';

class Storage {
  static Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/products.json');
  }

  static Future<File> _getTransactionFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/transactions.json');
  }

  /// Default seed products (first run) with asset images
  static List<Product> defaultProducts = [
    Product(
      id: '1',
      name: 'Notebook',
      supplier: 'National Bookstore',
      unit: 'pcs',
      quantity: 50,
      price: 25.00,
      imagePath: 'lib/assets/image_placeholder.png',
      quantityChange: 50,
    ),
    Product(
      id: '2',
      name: 'Ballpen',
      supplier: 'Pilot',
      unit: 'pcs',
      quantity: 100,
      price: 12.50,
      imagePath: 'lib/assets/image_placeholder.png',
      quantityChange: 100,
    ),
    Product(
      id: '3',
      name: 'Calculator',
      supplier: 'Casio',
      unit: 'pcs',
      quantity: 20,
      price: 450.00,
      imagePath: 'lib/assets/image_placeholder.png',
      quantityChange: 20,
    ),
  ];

  /// Default seed products (first run) with asset images
  static List<Transaction> defaultTransactions = [
    Transaction(
      id: '1',
      name: 'Notebook',
      supplier: 'National Bookstore',
      quantityChange: 50,
    ),
    Transaction(
      id: '2',
      name: 'Ballpen',
      supplier: 'Pilot',
      quantityChange: 100,
    ),
    Transaction(
      id: '3',
      name: 'Calculator',
      supplier: 'Casio',
      quantityChange: 20,
    ),
  ];

  /// Load products. If no file exists, write defaults to file first.
  static Future<List<Product>> loadProducts() async {
    final file = await _getFile();

    if (!await file.exists()) {
      // first run → write defaults into storage
      final jsonList = defaultProducts.map((p) => p.toJson()).toList();
      await file.writeAsString(jsonEncode(jsonList));
      return defaultProducts;
    }

    // file already exists → load normally
    final content = await file.readAsString();
    final List<dynamic> jsonList = jsonDecode(content);
    return jsonList.map((j) => Product.fromJson(j)).toList();
  }

  static Future<List<Transaction>> loadTransactions() async {
    final file = await _getTransactionFile();

    if (!await file.exists()) {
      // first run → write defaults into storage
      final jsonList = defaultTransactions.map((p) => p.toJson()).toList();
      await file.writeAsString(jsonEncode(jsonList));
      return defaultTransactions;
    }

    // file already exists → load normally
    final content = await file.readAsString();
    final List<dynamic> jsonList = jsonDecode(content);
    return jsonList.map((j) => Transaction.fromJson(j)).toList();
  }

  /// Save updated product and transaction list
  static Future<void> saveProducts(List<Product> products) async {
    final file = await _getFile();
    final jsonList = products.map((p) => p.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonList));
  }

  static Future<void> saveTransactions(List<Transaction> transactions) async {
    final file = await _getTransactionFile();
    final jsonList = transactions.map((p) => p.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonList));
  }
}
