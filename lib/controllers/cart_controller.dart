import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';
import '../services/sales_service.dart';

class CartController extends GetxController {
  final cartItems = <Product, int>{}.obs;
  final _salesService = SalesService();
  final salesUpdated = false.obs;

  void addToCart(Product product, [int quantity = 1]) {
    cartItems[product] = (cartItems[product] ?? 0) + quantity;
    update();
  }

  void removeFromCart(Product product) {
    cartItems.remove(product);
    update();
  }

  void incrementQuantity(Product product) {
    if (cartItems.containsKey(product)) {
      cartItems[product] = cartItems[product]! + 1;
      update();
    }
  }

  void decrementQuantity(Product product) {
    if (cartItems.containsKey(product)) {
      if (cartItems[product]! > 1) {
        cartItems[product] = cartItems[product]! - 1;
      } else {
        cartItems.remove(product);
      }
      update();
    }
  }

  void clearCart() {
    cartItems.clear();
    update();
  }

  void checkout() async {
    for (final entry in cartItems.entries) {
      await _salesService.incrementSales(entry.key, entry.value);
    }
    salesUpdated.toggle(); // Move this before clearing cart
    clearCart();
    Get.snackbar(
      'Success',
      'Your order has been placed!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF2E7D32),
      colorText: const Color(0xFFFAF9F6),
    );
  }

  double get subtotal => cartItems.entries
      .map((entry) => entry.key.price * entry.value)
      .fold(0, (sum, price) => sum + price);

  double get taxes => subtotal * 0.1; // 10% tax rate

  double get total => subtotal + taxes;

  int get itemCount =>
      cartItems.values.fold(0, (sum, quantity) => sum + quantity);
}
