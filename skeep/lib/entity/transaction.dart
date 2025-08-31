class Transaction {
  String id;
  String name;
  String supplier;
  int quantityChange; // default to 0 if not provided

  Transaction({
    required this.id,
    required this.name,
    required this.supplier,
    required this.quantityChange,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'supplier': supplier,
        'quantityChange': quantityChange,
      };

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json['id'],
        name: json['name'],
        supplier: json['supplier'],
        quantityChange: json['quantityChange'],
      );
}
