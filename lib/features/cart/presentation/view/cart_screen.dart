import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_flutter_app/core/widgets/custom_appbar.dart';
import 'package:shopping_flutter_app/features/cart/presentation/widgets/cart_item.dart';

import '../../../../core/utils/constants/ui_result.dart';
import '../../../home/domain/entities/product_entity.dart';
import '../ViewModel/cart_viewmodel.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CartScreen();
}

class _CartScreen extends State<CartScreen> {
  @override
  void initState() {
    Future.microtask(() {
      // call only once
      context.read<CartViewModel>().loadCart();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // need to watch any changeListener to update UI
    final viewModel = context.watch<CartViewModel>();
    final result = viewModel.cartResult;

    Widget body;

    if (result is Loading) {
      body = const Center(child: CircularProgressIndicator());
    } else if (result is Error<List<ProductData>>) {
      body = Center(child: Text(result.message));
    } else if (result is Success<List<ProductData>>) {
      final products = result.data;
      if (products.isNotEmpty) {
        body = Column(
          children: [
            Expanded(
                child: ListView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return CartItem(
                  productData: products[index],
                  onDeletePressed: () {
                    viewModel.deleteProduct(products[index].id);
                  },
                  onIncreasePressed: () {
                    viewModel.increaseQuantity(products[index]);
                  },
                  onDecreasePressed: () {
                    if (products[index].quantity != 1) {
                      viewModel.decreaseQuantity(products[index]);
                    }
                  },
                );
              },
            )),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 60,
              color: Colors.cyan.shade300,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Price'.tr(),
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                    Text(
                      "${viewModel.totalPrice} ${"SAR".tr()}",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      } else {
        body = Container(
          alignment: Alignment.center,
          child: Text('Cart is empty'.tr(),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
        );
      }
    } else {
      body = const SizedBox.shrink(); // fallback
    }
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppbar(title: 'My Cart'.tr()),
        body: body);
  }
}
