import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rexparts/model/admin_product_model.dart';
import 'package:rexparts/service/admin_service.dart';

class FavoutareProvider extends ChangeNotifier {
  FirebaseService productService = FirebaseService();

  Future<void> favouritesCliscked(String id, bool status) async {
    await productService.favListClicked(id, status);
    log('fvt controler');
    notifyListeners();
  }

  bool favouritesCheck(ProductModel product) {
    final currentuser = FirebaseAuth.instance.currentUser;
    final user = currentuser!.email ?? currentuser.phoneNumber;
    log('Fav added');
    return !product.favorite!.contains(user);
  }
}
