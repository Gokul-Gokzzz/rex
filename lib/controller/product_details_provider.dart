import 'package:flutter/material.dart';

class ProductDetailsProvider extends ChangeNotifier {
  int i = 1;
  increment() {
    i++;
    notifyListeners();
  }

  decrement() {
    if (i > 1) {
      i--;
    }
    notifyListeners();
  }

  clear() {
    i = 1;
    notifyListeners();
  }
}
