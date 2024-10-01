import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cart_application/model/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var products = <ProductModel>[].obs;
  var cart = <ProductModel>[].obs;
  var cartCount = <int, int>{}.obs; 

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products'));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      for (var product in jsonResponse['products']) {
        products.add(ProductModel.fromJson(product));
      }
    }
  }

  void addToCart(ProductModel product) {
    cart.add(product);
    cartCount[product.id] = (cartCount[product.id] ?? 0) + 1; 
  }

  void removeFromCart(ProductModel product) {
    cart.remove(product);
    cartCount[product.id] = (cartCount[product.id] ?? 1) - 1; 
    if (cartCount[product.id] == 0) {
      cartCount.remove(product.id); 
    }
  }
}
