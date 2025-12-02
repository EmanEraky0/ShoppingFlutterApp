import 'dart:ffi';

import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../features/auth/login/domain/entities/user_entity.dart';
import '../../../features/home/domain/entities/product_entity.dart';

class LocalStorage {
  static const _usersBox = 'usersBox';
  static const cartBoxName = 'cartBox';
  static const _prefsUserIdKey = 'userId';
  static const _prefsAuthTokenKey = 'authToken';
  static const _favoriteBoxName = 'favoriteBox';

  late Box<ProductData> _cartBox;
  late Box<UserEntity> _userBox;
  late Box<List<int>> _favoriteBox;

  Future<void> init() async {
    _cartBox = await Hive.openBox<ProductData>(cartBoxName);
    _userBox = await Hive.openBox<UserEntity>(_usersBox);
    _favoriteBox = await Hive.openBox<List<int>>(_favoriteBoxName);
  }

  Future<void> saveUserSession(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_prefsUserIdKey, userId);
    // await prefs.setString(_prefsAuthTokenKey, token);
  }

  Future<int> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_prefsUserIdKey) ?? 0;
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  /// 🗃️ Hive (complex objects)

  String _cartKey(int userId, dynamic productId) => '${userId}_$productId';

  // existing. the SAME object reference stored in your ViewModel list _cart
  // when update in existing.quantity change  reference the _cart see this change
  // Flutter sees the updated quantity in your _cart list instantly,

  String _favKey(int userId) => "fav_$userId";

  Future<void> addFavorite(
    int userId,
    int productId,
  ) async {
    final key = _favKey(userId);

    final favorites = _favoriteBox.get(key, defaultValue: []) ?? [];

    if (!favorites.contains(key)) {
      favorites.add(productId);
      await _favoriteBox.put(key, favorites);
    }
  }
  Future<void> removeFavorite(int userId, int productId) async {
    final key = _favKey(userId);

    final favorites = _favoriteBox.get(key, defaultValue: []) ?? [];

    favorites.remove(productId);
    await _favoriteBox.put(key, favorites);
  }

  Future<void> toggleFavorite(int userId, int productId) async {
    final key = _favKey(userId);

    final favorites = _favoriteBox.get(key, defaultValue: []) ?? [];

    if (favorites.contains(productId)) {
      favorites.remove(productId);
    } else {
      favorites.add(productId);
    }

    await _favoriteBox.put(key, favorites);
  }

  Future<bool> isFavorite(int userId, int productId) async {
    final favs = await getFavorites(userId);
    return favs.contains(productId);
  }
  Future<List<int>> getFavorites(int userId) async {
    final key = _favKey(userId);

    return _favoriteBox.get(key, defaultValue: []) ?? [];
  }

  Future<void> updateProductQuantity(
      int userId, ProductData product, bool isIncrease) async {
    if (!_cartBox.isOpen) await init();

    final key = _cartKey(userId, product.id);
    final existing = _cartBox.get(key);

    if (existing != null) {
      int qty = existing.quantity ?? 1;

      if (isIncrease) {
        qty++;
      } else {
        qty--;
      }

      if (qty <= 0) {
        await _cartBox.delete(key); // remove product completely
      } else {
        existing.quantity = qty;
        await _cartBox.put(key, existing);
      }
    } else {
      // Product doesn't exist → add new with quantity = 1
      // final newProduct = ProductData(id: product.id, quantity: 1);
      product.quantity = 1;
      await _cartBox.put(key, product);
    }
  }

  Future<List<ProductData>> getCart(int userId) async {
    if (!_cartBox.isOpen) {
      _cartBox = await Hive.openBox<ProductData>(cartBoxName);
    }

    final prefix = '${userId}_';
    final keysForUser =
        _cartBox.keys.where((k) => k.toString().startsWith(prefix));
    return keysForUser.map((k) => _cartBox.get(k)!).toList();
  }

  /// '4-1 , 4-2'
  Future<void> clearCart(int userId) async {
    final prefix = '${userId}_';
    final keysToDelete =
        _cartBox.keys.where((k) => k.toString().startsWith(prefix)).toList();
    if (keysToDelete.isNotEmpty) {
      await _cartBox.deleteAll(keysToDelete);
    }
  }

  Future<void> clearItemInCart(int userId, int productId) async {
    final cartKey = '${userId}_$productId';
    _cartBox.containsKey(cartKey);
    if (_cartBox.containsKey(cartKey)) {
      await _cartBox.delete(cartKey);
    }
  }

  Future<void> saveUser(UserEntity user) async {
    await _userBox.put('currentUser', user);
  }

  Future<UserEntity?> getUser() async {
    return _userBox.get('currentUser');
  }

  Future<void> clearUser() async {
    await _userBox.delete('currentUser');
  }
}
