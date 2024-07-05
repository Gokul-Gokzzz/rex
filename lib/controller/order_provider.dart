import 'package:flutter/material.dart';

class OrderProvider with ChangeNotifier {
  List<Map<String, dynamic>> orders = [];

  void addOrder(Map<String, dynamic> order) {
    orders.add(order);
    notifyListeners();
  }

  void addOrders(List<Map<String, dynamic>> newOrders) {
    orders.addAll(newOrders);
    notifyListeners();
  }
}
