import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopping_flutter_app/features/home/domain/entities/product_entity.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as ProductData;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 🧩 Collapsing Image Section
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            // Keeps toolbar visible after collapse
            backgroundColor: Colors.cyan.shade700,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                product.title,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              background: Hero(
                tag: product.image, // Optional hero animation
                child: Image.network(
                  product.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // 🧾 Product Info Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${product.price} ${"SAR".tr()}",
                    style: TextStyle(
                      color: Colors.cyan.shade700,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  Text(
                    'Description'.tr(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description!,
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),

      // 🛒 Floating "Add to Cart" Button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Colors.cyan.shade700,
        icon: const Icon(Icons.shopping_cart),
        label: Text("Add to Cart".tr()),
      ),
    );
  }
}
