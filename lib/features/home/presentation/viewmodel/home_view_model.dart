import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_flutter_app/core/utils/constants/ui_result.dart';
import 'package:shopping_flutter_app/features/home/domain/entities/product_entity.dart';
import 'package:shopping_flutter_app/features/home/domain/usecases/home_use_cases.dart';
import '../../../../core/network/local/local_storage.dart';
import '../../../favorite/domain/usecase/favorite_usecase.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeUseCases homeUseCases;
  final FavoriteUseCase favoritesUseCase;

  final LocalStorage localStorage;
  HomeViewModel(this.homeUseCases, this.localStorage,this.favoritesUseCase);

  UiResult<List<ProductData>>? state;

  List<int> _favorites = [];
  List<int> get favorites => _favorites;

  bool addCartLoading =false;

  Future<void> loadFavorites() async {
    final userId = await localStorage.getUserId();
    _favorites = await favoritesUseCase.getFavorites(userId);
    notifyListeners();
  }

  Future<void> toggleFavorite(int productId) async {
    final userId = await localStorage.getUserId();
    await favoritesUseCase.toggleFavorite(userId, productId);
    await loadFavorites();
  }

  bool isFavorite(int productId) {
    return _favorites.contains(productId);
  }


  Future<void> clickAddCart(ProductData product) async {
    addCartLoading =true;
    notifyListeners();
    try {
      final userId = await localStorage.getUserId();
         await homeUseCases.onAddCart(userId, product, true);
    }catch (e) {
     Error("Failed to add cart: $e");
    }
    addCartLoading =false;
    notifyListeners();
  }

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
}
