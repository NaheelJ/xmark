class Product {
  final String name;
  final String narration;
  final int price;

  // Constructor
  Product({
    required this.name,
    required this.narration,
    required this.price,
  });

  // Factory constructor to create a Product from a map (e.g., JSON or dynamic data)
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] as String,
      narration: json['narration'] as String,
      price: json['price'] as int,
    );
  }

  // Utility function to handle conversion of a list of JSON-like maps to Product objects
  static List<Product> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Product.fromJson(json)).toList();
  }
}