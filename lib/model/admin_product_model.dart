class ProductModel {
  final String? id;
  final String name;
  final String? category;
  final String description;
  final double price;
  final String imageUrl;
  final int? quantity;
  List? favorite = [];

  ProductModel({
    this.id,
    required this.name,
    this.category,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.quantity,
    this.favorite,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'favorite': favorite,
    };
  }

  factory ProductModel.fromJson(data) {
    return ProductModel(
      id: data['id'],
      name: data['name'],
      category: data['category'],
      description: data['description'],
      price: data['price'],
      imageUrl: data['imageUrl'],
      quantity: data['quantity'],
      favorite: List<String>.from(data['favorite']),
    );
  }
}
