// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rexparts/controller/admin_controller.dart';
import 'package:rexparts/controller/favoutare_provider.dart';
import 'package:rexparts/model/admin_product_model.dart';
import 'package:rexparts/view/product_details/product_details.dart';

class ProductCategory extends StatefulWidget {
  final String? category;
  const ProductCategory({super.key, this.category});

  @override
  _ProductCategoryState createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  @override
  void initState() {
    super.initState();
    final prdProvider = Provider.of<ProductProvider>(context, listen: false);
    prdProvider.fetchProductList(widget.category ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 20),
            child: Text(
              widget.category ?? 'All Categories',
              style: const TextStyle(fontSize: 25),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              onChanged: (value) {
                Provider.of<ProductProvider>(context, listen: false)
                    .searchProducts(value);
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                label: const Text('Search.....'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (context, prdProvider, child) {
                if (prdProvider.filteredProductList.isEmpty) {
                  return const Center(
                    child: Text('No Data'),
                  );
                } else {
                  return GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: prdProvider.filteredProductList.isNotEmpty
                        ? prdProvider.filteredProductList.length
                        : prdProvider.allproducts.length,
                    itemBuilder: (context, index) {
                      ProductModel product =
                          prdProvider.filteredProductList.isNotEmpty
                              ? prdProvider.filteredProductList[index]
                              : prdProvider.allproducts[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailPage(
                                product: product,
                              ),
                            ),
                          );
                        },
                        child: GridTile(
                          footer: GridTileBar(
                            backgroundColor: Colors.black54,
                            title: Text(
                              product.name,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          child: Stack(
                            children: [
                              SizedBox(
                                height: 205,
                                width: 300,
                                child: Image.network(
                                  product.imageUrl,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Consumer<FavoutareProvider>(
                                  builder: (context, value, child) =>
                                      IconButton(
                                    onPressed: () async {
                                      final fav =
                                          value.favouritesCheck(product);
                                      await value.favouritesCliscked(
                                          product.id!, fav);
                                    },
                                    icon: value.favouritesCheck(product)
                                        ? const Icon(
                                            Icons.favorite_border_outlined,
                                            color: Colors.red,
                                          )
                                        : const Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
