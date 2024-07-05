import 'package:flutter/material.dart';

class BottomNavProvider extends ChangeNotifier {
  int currentIndex = 0;
  int initIndex = 0;
  currentIndexChanging(value) {
    currentIndex = value;
    notifyListeners();
  }

  void setInitIndex(int index) {
    initIndex = index;
    currentIndex = index;
    notifyListeners();
  }
}
