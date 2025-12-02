import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_flutter_app/core/widgets/custom_appbar.dart';
import '../../../../core/utils/constants/ui_result.dart';
import '../../../../core/widgets/product_item.dart';
import '../../../home/domain/entities/product_entity.dart';
import '../../../home/presentation/viewmodel/home_view_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final state = viewModel.state;
    final isLoading = viewModel.addCartLoading;

    final screenWidth = MediaQuery.of(context).size.width;
    // 🟢 NEW: Calculate dynamic column count
    int crossAxisCount = 2;
    if (screenWidth > 600 && screenWidth <= 900) {
      crossAxisCount = 3; // for tablets
    } else if (screenWidth > 900) {
      crossAxisCount = 4; // for large screens
    }
    Widget body;

    if (state is Loading) {
      body = const Center(child: CircularProgressIndicator());
    } else if (state is Error<List<ProductData>>) {
      body = Center(
        child: Text(
          state.message.toString(),
          style: const TextStyle(color: Colors.red, fontSize: 16),
        ),
      );
    } else if (state is Success<List<ProductData>>) {
      final products = state.data;
      body = GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 3 / 4,
        ),
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
            isLoading: isLoading,
          );
        },
      );
    } else {
      body = const SizedBox.shrink(); // fallback
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppbar(title: "All Products".tr()),
        body: body);
  }
}
