import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rexparts/controller/cart_provider.dart';
import 'package:rexparts/model/admin_product_model.dart';

import 'package:rexparts/view/product_details/product_details.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return ListView.builder(
            itemCount: cartProvider.getOrders().length,
            itemBuilder: (context, index) {
              final order = cartProvider.getOrders()[index];
              return Card(
                elevation: 4.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  leading: SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.network(
                      order.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(order.name),
                  subtitle: Text(order.name),
                  onTap: () {
                    final product = ProductModel(
                      id: order.id,
                      name: order.name,
                      description: 'Product description here',
                      imageUrl: order.imageUrl,
                      price: order.price,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailPage(product: product),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
