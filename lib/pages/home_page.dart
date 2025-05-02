import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/product_card.dart';
import '../widgets/sales_chart.dart';
import '../controllers/product_controller.dart';
import '../controllers/cart_controller.dart';
import 'cart_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();
    final cartController = Get.find<CartController>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1), // Light Cream background
      appBar: AppBar(
        title: const Text(
          'Luxury Jewelry',
          style: TextStyle(
              color: Color(0xFFFAF9F6),
              fontWeight: FontWeight.w500), // Ivory text
        ),
        backgroundColor: const Color(0xFFD4AF37), // Gold
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined,
                    color: Color(0xFFFAF9F6)),
                onPressed: () => Get.to(() => const CartPage()),
              ),
              Obx(() => Positioned(
                    right: 8,
                    top: 8,
                    child: cartController.cartItems.isEmpty
                        ? const SizedBox()
                        : Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Color(0xFF1A237E),
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              cartController.cartItems.length.toString(),
                              style: const TextStyle(
                                color: Color(0xFFFAF9F6), 
                                fontSize: 12,
                              ),
                            ),
                          ),
                  )),
            ],
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SalesChart(),
            ),
          ),
          Obx(() {
            if (productController.isLoading.value) {
              return const SliverFillRemaining(
                child: Center(
                    child: CircularProgressIndicator(
                  color: Color(0xFFD4AF37), // Gold
                )),
              );
            }
            if (productController.products.isEmpty) {
              return const SliverFillRemaining(
                child: Center(
                  child: Text(
                    'No products available',
                    style: TextStyle(
                      color: Color(0xFF212121), // Dark Charcoal
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            }
            return SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = productController.products[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Hero(
                        tag: 'product-${product.id}',
                        child: ProductCard(product: product),
                      ),
                    );
                  },
                  childCount: productController.products.length,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
