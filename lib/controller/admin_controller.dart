import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rexparts/model/admin_product_model.dart';
import 'package:rexparts/service/admin_service.dart';
import 'package:rexparts/service/auth_service.dart';
import 'package:rexparts/service/noti_service.dart';

class ProductProvider with ChangeNotifier {
  final FirebaseService firebaseService = FirebaseService();
  final formKey = GlobalKey<FormState>();
  final productNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  List<ProductModel> productList = [];
  List<ProductModel> filteredProductList = [];
  List<ProductModel> allproducts = [];
  AuthService authService = AuthService();

  String? selectedCategory;
  File? image;
  NotificationService notificationService = NotificationService();

  final ImagePicker picker = ImagePicker();

  void setImage(File pickedImage) {
    image = pickedImage;
    notifyListeners();
  }

  void updateProducts(List<ProductModel> products) {
    allproducts = products;
    notifyListeners();
  }

  Future<void> addProduct({
    required String name,
    required String category,
    required String description,
    required double price,
    File? image,
  }) async {
    try {
      String imageUrl = '';
      if (image != null) {
        imageUrl = await firebaseService.uploadImage(image);
      }

      final product = ProductModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        category: category,
        description: description,
        price: price,
        favorite: [],
        imageUrl: imageUrl,
      );

      await firebaseService.addProduct(product);
      notifyListeners();
      await authService.getAllUsers();

      // await notificationService.showNotification(
      //   title: 'New Product Added',
      //   body: '$name is now available in $category category!',
      // );
    } catch (e) {
      log('Error adding product: $e');
    }
  }

  Future<void> fetchProductList(String category) async {
    try {
      productList = await firebaseService.getCategory(category);
      filteredProductList = productList;
      notifyListeners();
    } catch (error) {
      log('Error fetching product list: $error');
    }
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      filteredProductList = productList;
    } else {
      filteredProductList = productList
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  getProduct() async {
    log('message');
    allproducts = await firebaseService.getAllProduct();
    log(allproducts.length.toString());
    notifyListeners();
  }
}
