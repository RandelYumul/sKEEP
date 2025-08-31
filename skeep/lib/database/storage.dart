import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../entity/product.dart';

class Storage {
  static Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/products.json');
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
    ),
    Product(
      id: '2',
      name: 'Ballpen',
      supplier: 'Pilot',
      unit: 'pcs',
      quantity: 100,
      price: 12.50,
      imagePath: 'lib/assets/image_placeholder.png',
    ),
    Product(
      id: '3',
      name: 'Calculator',
      supplier: 'Casio',
      unit: 'pcs',
      quantity: 20,
      price: 450.00,
      imagePath: 'lib/assets/image_placeholder.png',
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

  /// Save updated product list
  static Future<void> saveProducts(List<Product> products) async {
    final file = await _getFile();
    final jsonList = products.map((p) => p.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonList));
  }
}
