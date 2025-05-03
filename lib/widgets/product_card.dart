import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';
import '../controllers/cart_controller.dart';
import '../pages/product_details.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return InkWell(
      onTap: () => Get.to(() => ProductDetailsPage(product: product)),
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
            color: Color(0xFFD4AF37),
            width: 0.5,
          ), // Gold border
        ),
        elevation: 4,
        shadowColor: const Color(0xFF212121).withOpacity(0.3),
        color: const Color(0xFFFAF9F6), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.network(
                      product.image,
                      width: double.infinity,
                      fit: BoxFit.contain,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: const Color(0xFFF5F5F5),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFFD4AF37), 
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFFF5F5F5),
                          child: const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              size: 40,
                              color: Color(0xFF757575), 
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFF1A237E,
                        ).withOpacity(0.9), // Deep Royal Blue
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Color(0xFFD4AF37),
                            size: 16,
                          ), // Gold
                          const SizedBox(width: 4),
                          Text(
                            product.rating.toStringAsFixed(1),
                            style: const TextStyle(
                              color: Color(0xFFFAF9F6), // Ivory
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF212121), // Dark Charcoal
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF757575), // Medium Gray
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFD4AF37), // Gold
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          cartController.addToCart(product);
                          Get.snackbar(
                            'Added to Cart',
                            '${product.title} has been added to your cart',
                            snackPosition: SnackPosition.BOTTOM,
                            margin: const EdgeInsets.all(8),
                            backgroundColor: const Color(
                              0xFF2E7D32,
                            ), // Emerald Green
                            colorText: const Color(0xFFFAF9F6), 
                            duration: const Duration(seconds: 2),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD4AF37), 
                          foregroundColor: const Color(0xFFFAF9F6), 
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
