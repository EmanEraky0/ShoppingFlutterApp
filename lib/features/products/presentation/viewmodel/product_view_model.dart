import 'package:flutter/cupertino.dart';

import '../../../../core/network/local/local_storage.dart';
import '../../../../core/utils/constants/ui_result.dart';
import '../../../home/domain/entities/product_entity.dart';

class ProductViewModel extends ChangeNotifier {
  final LocalStorage localStorage;

  ProductViewModel(this.localStorage);

  UiResult<String> _favoriteResult = Loading();
  UiResult<String> get favoriteResult => _favoriteResult;

  Future<void> addFavorite(ProductData product) async {
    _favoriteResult = Loading();
    notifyListeners();

    try {
      final userId = await localStorage.getUserId();
       await localStorage.addFavorite(userId,product.id); // store cart in memory
      _favoriteResult = Success("Success add to favorite");
    } catch (e) {
      _favoriteResult = Error("Failed to add fvorite: $e");
    }

    notifyListeners();
  }
}
