import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_flutter_app/core/widgets/product_item.dart';
import 'package:shopping_flutter_app/features/home/domain/entities/product_entity.dart';

import '../../../../core/network/local/local_storage.dart';
import '../../../../injections.dart';
import '../viewmodel/home_view_model.dart';

class ProductCarousel extends StatelessWidget {

  final List<ProductData> products;


  const ProductCarousel({super.key,required this.products});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HomeViewModel>();

    return SizedBox(
      height: 250,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final productItem = products[index];
          return ProductItem(
            product: productItem,
            isFavorite: viewModel.isFavorite(productItem.id),
            onItemPressed: () {
              Navigator.pushNamed(
                context,
                '/details',
                arguments: productItem,
              );
            },
            onFavoritePressed: () {
              viewModel.toggleFavorite(productItem.id);
            },
            onCartPressed: () {
              viewModel.clickAddCart(productItem);
            },
            // isLoading: isLoading,
          );
        },
      ),
    );
  }
}
