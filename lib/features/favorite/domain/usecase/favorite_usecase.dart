import '../repositories/favorite_repository.dart';

class FavoriteUseCase {
  final FavoriteRepository repository;

  FavoriteUseCase(this.repository);

  Future<List<int>> getFavorites(int userId) {
    return repository.getFavorites(userId);
  }

  Future<void> toggleFavorite(int userId,int productId) {
    return repository.toggleFavorite(userId,productId);
  }
}