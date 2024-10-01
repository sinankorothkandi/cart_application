import 'dart:convert';
import 'package:cart_application/views/product_page.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  Future<void> login(String username, String password) async {
    isLoading.value = true;
    final response = await http.post(
      Uri.parse('https://dummyjson.com/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
        'expiresInMins': 30,
      }),
    );
    if (response.statusCode == 200) {
      Get.offAll(const ProductPage());
    } else {
      Get.snackbar('Error', 'Login Failed');
    }
    isLoading.value = false;
  }
}
