import '../../../../core/network/local/local_storage.dart';

class FavoriteRepository {
  final LocalStorage localStorage;

  FavoriteRepository(this.localStorage);

  Future<List<int>> getFavorites(int userId) {
    return localStorage.getFavorites(userId);
  }

  Future<void> toggleFavorite(int userId, int productId) {
    return localStorage.toggleFavorite(userId, productId);
  }
}