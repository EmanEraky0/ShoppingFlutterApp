import 'package:flutter/cupertino.dart';

import '../../../../core/network/local/local_storage.dart';
import '../../../../core/utils/constants/ui_result.dart';
import '../../../home/domain/entities/product_entity.dart';
import '../../../home/domain/usecases/home_use_cases.dart';

class FavoritesViewModel extends ChangeNotifier {
  final LocalStorage localStorage;
  final HomeUseCases homeUseCases;


  FavoritesViewModel(this.localStorage,this.homeUseCases);
  List<int> _favorites = [];
  List<int> get favorites => _favorites;


  UiResult<List<ProductData>>? state;

  Future<void> getAllProducts() async {
    state = Loading();
    notifyListeners();
    try {
      state= await homeUseCases.call();

    } catch (e) {
      state = Error(e.toString());
    }
    notifyListeners();
  }

  List<ProductData> get favoriteProducts {
    if (state is! Success<List<ProductData>>) return [];
    final products = (state as Success<List<ProductData>>).data;
    return products.where((p) => _favorites.contains(p.id)).toList();
  }

  Future<void> loadFavorites() async {
    final userId = await localStorage.getUserId();
    _favorites = await localStorage.getFavorites(userId);
    notifyListeners();
  }

  Future<void> toggleFavorite(int productId) async {
    final userId = await localStorage.getUserId();
    await localStorage.toggleFavorite(userId, productId);

    await loadFavorites();
  }

  bool isFavorite(int productId) {
    return _favorites.contains(productId);
  }
}
