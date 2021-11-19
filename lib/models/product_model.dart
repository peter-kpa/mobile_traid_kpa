class Product {
  String id;
  String name;
  String parentId;
  String parenName;
  bool isGroup;
  double price;

  Product({
    required this.id,
    required this.name,
    required this.parentId,
    required this.parenName,
    required this.isGroup,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'] as String,
        name: json['name'] as String,
        parentId: json['parentId'] as String,
        parenName: json['parentName'] as String,
        isGroup: json['isGroup'] as bool,
        price: json['price'].toDouble());
  }
}
