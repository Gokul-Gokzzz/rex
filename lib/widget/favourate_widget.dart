// ignore_for_file: unused_local_variable, camel_case_types, unnecessary_null_comparison, avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rexparts/controller/admin_controller.dart';
import 'package:rexparts/controller/favoutare_provider.dart';
import 'package:rexparts/model/admin_product_model.dart';
import 'package:rexparts/view/product_details/product_details.dart';
import 'package:rexparts/widget/text_widget.dart';

class Fav extends StatelessWidget {
  const Fav({super.key});

  @override
  Widget build(BuildContext context) {
    bool? thisuser;
    return Consumer2<FavoutareProvider, ProductProvider>(
        builder: (context, favvalue, addvalue, child) {
      final favlistItems = checkUser(favvalue, addvalue);
      if (favlistItems.isEmpty) {
        return Center(
          child: TextWidget().text(data: "There is no items in the Favourites"),
        );
      }
      return ListView.builder(
        itemCount: favlistItems.length,
        itemBuilder: (context, index) {
          final item = favlistItems[index];
          return Container(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (item.id == FirebaseAuth.instance.currentUser!.uid) {
                      thisuser = true;
                    } else {
                      thisuser = false;
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailPage(product: item)));
                  },
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: item.imageUrl != null
                                ? NetworkImage(item.imageUrl) as ImageProvider
                                : const AssetImage(
                                    'assets/images/dummy image.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: TextWidget().text(
                          data: item.name.toUpperCase(),
                          weight: FontWeight.bold),
                      subtitle: TextWidget().text(
                          data: "${item.price}",
                          color: Colors.green,
                          weight: FontWeight.bold),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.red,
                        ),
                        onPressed: () async {
                          final wish = favvalue.favouritesCheck(item);
                          await favvalue.favouritesCliscked(item.id!, wish);
                        },
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey[300],
                )
              ],
            ),
          );
        },
      );
    });
  }

  List<ProductModel> checkUser(
      FavoutareProvider wishlistProvider, ProductProvider productProvider) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return [];
    }
    final user = currentUser.uid;
    List<ProductModel> myProducts = [];
    for (var prdo in productProvider.allproducts) {
      if (prdo.favorite!.contains(user)) {
        myProducts.add(prdo);
      }
    }
    return myProducts;
  }
}
