import 'package:flutter/cupertino.dart';

import '../../../../core/network/local/local_storage.dart';
import '../../../../core/utils/constants/ui_result.dart';
import '../../../home/domain/entities/product_entity.dart';

class CartViewModel extends ChangeNotifier {
  final LocalStorage localStorage;

  CartViewModel(this.localStorage);

  /// We now store cart items IN MEMORY
  List<ProductData> _cart =
      []; // update Ui without call loadCart in every change
  UiResult<List<ProductData>> _cartResult = Loading();

  UiResult<List<ProductData>> get cartResult => _cartResult;

  List<ProductData> get cart => _cart;

  Future<void> loadCart() async {
    _cartResult = Loading();
    notifyListeners();

    try {
      final userId = await localStorage.getUserId();
      _cart = await localStorage.getCart(userId); // store cart in memory
      _cartResult = Success(_cart);
    } catch (e) {
      _cartResult = Error("Failed to load cart: $e");
    }

    notifyListeners();
  }

  Future<void> deleteProduct(int productId) async {
    final userId = await localStorage.getUserId();

    await localStorage.clearItemInCart(userId, productId);

    // update in-memory list
    _cart.removeWhere((p) => p.id == productId);

    // update UI
    _cartResult = Success(_cart);
    notifyListeners();
  }

  Future<void> increaseQuantity(ProductData product) async {
    final userId = await localStorage.getUserId();

    await localStorage.updateProductQuantity(userId, product, true); //

    _cartResult = Success(_cart);
    notifyListeners();
  }

  // ------------------------------------------------------------
  Future<void> decreaseQuantity(ProductData product) async {
    final userId = await localStorage.getUserId();

    await localStorage.updateProductQuantity(userId, product, false);

    _cartResult = Success(_cart);
    notifyListeners();
  }

  double get totalPrice {
    double total = 0.0;

    for (var item in _cart) {
      final qty = item.quantity ?? 1;
      total += (item.price) * qty;
    }

    return total;
  }
}
