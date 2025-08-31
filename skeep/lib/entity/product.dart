class Product {
  String id;
  String name;
  String supplier;
  String unit;
  int quantity;
  double price;
  String imagePath;

  Product({
    required this.id,
    required this.name,
    required this.supplier,
    required this.unit,
    required this.quantity,
    required this.price,
    required this.imagePath,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'supplier': supplier,
        'unit': unit,
        'quantity': quantity,
        'price': price,
        'imagePath': imagePath,
      };

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        name: json['name'],
        supplier: json['supplier'],
        unit: json['unit'],
        quantity: json['quantity'],
        price: (json['price'] as num).toDouble(),
        imagePath: json['imagePath'],
      );
}
