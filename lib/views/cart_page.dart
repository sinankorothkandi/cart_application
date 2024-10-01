import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cart_application/controllers/product_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find<ProductController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Obx(() {
        if (productController.cart.isEmpty) {
          return const Center(child: Text('Your cart is empty'));
        } else {
          Map<int, int> productCountMap = {};
          for (var product in productController.cart) {
            productCountMap[product.id] =
                (productCountMap[product.id] ?? 0) + 1;
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: productCountMap.length,
            itemBuilder: (context, index) {
              final productId = productCountMap.keys.elementAt(index);
              final product =
                  productController.cart.firstWhere((p) => p.id == productId);
              final count = productCountMap[productId];

              return Card(
                elevation: 4.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/noImage.jpg',
                      height: 100.0,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        product.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('${product.price} USD'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'Quantity: ${count ?? 0}'), 
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () =>
                                    productController.addToCart(product),
                              ),
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  if (count != null && count > 1) {
                                    productController.removeFromCart(product);
                                  } else {
                                    productController.cart.remove(product);
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }
}
