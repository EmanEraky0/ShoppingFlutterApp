import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../features/home/domain/entities/product_entity.dart';

class ProductItem extends StatefulWidget {
  ProductData product;

  final VoidCallback? onFavoritePressed;
  final VoidCallback? onCartPressed;
  final VoidCallback? onItemPressed;
  final bool isFavorite;
  final bool? isLoading;

  ProductItem(
      {super.key,
      required this.product,
      this.onItemPressed,
      this.onFavoritePressed,
      this.onCartPressed,
      required this.isFavorite,
      this.isLoading});

  @override
  State<StatefulWidget> createState() => _ProductItem();
}

class _ProductItem extends State<ProductItem> {
  void toggleFavorite() {
    if (widget.onFavoritePressed != null) {
      widget.onFavoritePressed!(); // ⚡ Call the function
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onItemPressed,
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.network(widget.product.image,
                        height: 130,
                        width: double.infinity,
                        fit: BoxFit.cover)),
                Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: toggleFavorite,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          widget.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: widget.isFavorite ? Colors.red : Colors.grey,
                          size: 20,
                        ),
                      ),
                    )),
              ],
            ),
            // Product Image

            // Title + Price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.title,
                    maxLines: 1,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${widget.product.price} ${"SAR".tr()}",
                    style: TextStyle(
                      color: Colors.cyan.shade700,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Add to cart button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  widget.onCartPressed!();
                },
                icon: const Icon(Icons.add_shopping_cart, size: 18),
                label: Text("Add".tr()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan.shade600,
                  minimumSize: const Size(double.infinity, 36),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
