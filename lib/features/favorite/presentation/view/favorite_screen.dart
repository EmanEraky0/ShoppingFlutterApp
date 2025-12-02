import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_flutter_app/core/widgets/custom_appbar.dart';
import 'package:shopping_flutter_app/features/favorite/presentation/viewmodel/favorite_view_model.dart';
import '../../../../core/widgets/product_item.dart';
import '../../../home/domain/entities/product_entity.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});


  @override
  State<StatefulWidget> createState() => _FavoriteScreen();
}
class _FavoriteScreen extends State<FavoriteScreen>{

  List<ProductData> products = [];
  @override
  void initState() {
    Future.microtask(() {
      context.read<FavoritesViewModel>().loadFavorites();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FavoritesViewModel>();

    products = viewModel.favoriteProducts;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(title: "Favorites".tr()),
      body: products.isNotEmpty
          ? GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 3 / 4,
          ),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final productItem = products[index];
            return ProductItem(
                product: productItem,
                isFavorite: true,
                onItemPressed: () {
                  Navigator.pushNamed(context, '/details',
                      arguments: productItem);
                });
          })
          : Container(
        alignment: Alignment.center,
        child: Text(
          'Favorite is empty'.tr(),
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      ),
    );
  }
}
