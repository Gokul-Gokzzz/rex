// ignore_for_file: use_rethrow_when_possible

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rexparts/model/admin_product_model.dart';

class FirebaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<List<ProductModel>> getAllProduct() async {
    try {
      final snapshot = await firestore.collection('product').get();

      List<ProductModel> data = snapshot.docs
          .map(
            (e) => ProductModel.fromJson(e),
          )
          .toList();

      return data;
    } catch (e) {
      throw e;
    }
  }

  Future<String> uploadImage(File image) async {
    final storageRef = storage
        .ref()
        .child('product_images/${DateTime.now().millisecondsSinceEpoch}');
    final uploadTask = await storageRef.putFile(image);
    return await uploadTask.ref.getDownloadURL();
  }

  Future<void> addProduct(ProductModel product) async {
    await firestore.collection('product').doc(product.id).set(product.toJson());
  }

  Future<List<ProductModel>> getCategory(String category) async {
    try {
      final snapshot = await firestore
          .collection('product')
          .where('category', isEqualTo: category)
          .get();
      return snapshot.docs.map((doc) => ProductModel.fromJson(doc)).toList();
    } catch (error) {
      return [];
    }
  }

  Future<void> favListClicked(String id, bool status) async {
    try {
      if (status == true) {
        await firestore.collection('product').doc(id).update(
          {
            'favorite': FieldValue.arrayUnion(
              [firebaseAuth.currentUser!.uid],
            )
          },
        );
      } else {
        await firestore.collection('product').doc(id).update(
          {
            'favorite': FieldValue.arrayRemove(
              [firebaseAuth.currentUser!.uid],
            )
          },
        );
      }
    } catch (e) {
      // log("error is $e");
    }
  }
}
