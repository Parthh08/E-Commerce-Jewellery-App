import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product_model.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse('https://fakestoreapi.com/products/category/jewelery'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        products.value = data.map((json) => Product.fromJson(json)).toList();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch products');
    } finally {
      isLoading(false);
    }
  }
}
