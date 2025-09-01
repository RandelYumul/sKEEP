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
    //1
    Product(
      id: '1',
      name: 'Notebook',
      supplier: 'National Bookstore',
      unit: 'pcs',
      quantity: 50,
      price: 25.00,
      imagePath: 'lib/assets/notebook.png',
      quantityChange: 50,
    ),
    //2
    Product(
      id: '2',
      name: 'Ballpen',
      supplier: 'Pilot',
      unit: 'pcs',
      quantity: 100,
      price: 12.50,
      imagePath: 'lib/assets/ballpen.png',
      quantityChange: 100,
    ),
    //3
    Product(
      id: '3',
      name: 'Calculator',
      supplier: 'Casio',
      unit: 'pcs',
      quantity: 20,
      price: 450.00,
      imagePath: 'lib/assets/calculator.png',
      quantityChange: 20,
    ),
    //4
    Product(
      id: '4',
      name: 'Mongol Pencil 12pcs/box',
      supplier: 'Star 360 Phil Inc.',
      unit: 'pcs',
      quantity: 105,
      price: 119.00,
      imagePath: 'lib/assets/pencil.png',
      quantityChange: 105,
    ),
    //5
    Product(
      id: '5',
      name: 'Victory Yellow Pad',
      supplier: 'Paperlink, Inc.',
      unit: 'pcs',
      quantity: 75,
      price: 88.00,
      imagePath: 'lib/assets/yellowpad.png',
      quantityChange: 75,
    ),
    //6
    Product(
      id: '6',
      name: 'Crayons 24pc/box',
      supplier: 'Crayola',
      unit: 'pcs',
      quantity: 135,
      price: 114.00,
      imagePath: 'lib/assets/crayons.png',
      quantityChange: 135,
    ),
    //7
    Product(
      id: '7',
      name: 'Permanent Marker (Black)',
      supplier: 'Pilot',
      unit: 'pcs',
      quantity: 260,
      price: 33.00,
      imagePath: 'lib/assets/marker.png',
      quantityChange: 260,
    ),
    //8
    Product(
      id: '8',
      name: 'Hard Copy A4 Bond Paper',
      supplier: 'Advance Paper Corporation',
      unit: 'pcs',
      quantity: 30,
      price: 240.00,
      imagePath: 'lib/assets/bondpaper.png',
      quantityChange: 30,
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
    Transaction(
      id: '4',
      name: 'Mongol Pencil 12pcs/box',
      supplier: 'Star 360 Phil Inc.',
      quantityChange: 105,
    ),
    Transaction(
      id: '5',
      name: 'Victory Yellow Pad',
      supplier: 'Paperlink, Inc.',
      quantityChange: 75,
    ),
    Transaction(
      id: '6',
      name: 'Crayons 24pc/box',
      supplier: 'Crayola',
      quantityChange: 135,
    ),
    Transaction(
      id: '7',
      name: 'Permanent Marker (Black)',
      supplier: 'Pilot',
      quantityChange: 260,
    ),
    Transaction(
      id: '8',
      name: 'Hard Copy A4 Bond Paper',
      supplier: 'Advance Paper Corporation',
      quantityChange: 30,
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
