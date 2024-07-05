import 'package:flutter/material.dart';

import 'package:rexparts/service/admin_service.dart';

class CaroselProvider extends ChangeNotifier {
  final FirebaseService firebaseService = FirebaseService();

  int current = 0;
  carouselChange(int index) {
    current = index;
    notifyListeners();
  }
}
