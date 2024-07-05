import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final String id;
  String? userId;
  final String name;
  final double price;
  final String imageUrl;
  int quantity;
  final Timestamp? orderDate;
  bool? isOrder;

  CartModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.imageUrl,
      required this.quantity,
      this.orderDate,
      this.isOrder = false,
      this.userId});
  double get totalPrice => price * quantity;
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'orderDate': orderDate,
      'isOrder': isOrder,
      'userId': userId
    };
  }

  factory CartModel.fromJson(Map<String, dynamic> data) {
    return CartModel(
      id: data['id'],
      userId: data['userId'],
      name: data['name'],
      price: data['price'],
      imageUrl: data['imageUrl'],
      quantity: data['quantity'],
      orderDate: data['orderDate'],
      isOrder: data['isOrder'] ?? false,
    );
  }
}
