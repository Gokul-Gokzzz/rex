import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rexparts/controller/admin_controller.dart';
import 'package:rexparts/view/category/category.dart';
import 'package:rexparts/view/favourit/favourit.dart';
import 'package:rexparts/view/product_details/product_details.dart';
import 'package:rexparts/widget/home_widget.dart';
import 'package:rexparts/widget/slider.dart';

final slider = ['assets/slide1.jpg', 'assets/slide2.png', 'assets/slide3.jpg'];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<ProductProvider>(context, listen: false).getProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, top: 20, bottom: 20),
                    child: Text(
                      "Rexparts",
                      style: GoogleFonts.dmSerifText(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              slide(carouselimage: slider, height: 200),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CategoryScreen(),
                            ),
                          );
                        },
                        icon: const CircleAvatar(
                          backgroundColor: Color.fromARGB(170, 159, 214, 240),
                          child: Icon(
                            Icons.list,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      const Text(
                        'Category',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Favourites(),
                            ),
                          );
                        },
                        icon: const CircleAvatar(
                          backgroundColor: Color.fromARGB(170, 159, 214, 240),
                          child: Icon(
                            Icons.star_border,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      const Text(
                        'Favourites',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Text(
                'Popular',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              Consumer<ProductProvider>(builder: (context, value, child) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: value.allproducts.isNotEmpty
                      ? GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: value.allproducts.length,
                          itemBuilder: (context, index) {
                            final product = value.allproducts[index];

                            return productContainer(
                              context: context,
                              page: ProductDetailPage(product: product),
                              size: size,
                              image: product.imageUrl,
                              name: product.name,
                            );
                          },
                        )
                      : const Center(child: CircularProgressIndicator()),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
