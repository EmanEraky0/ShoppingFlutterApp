import 'package:dio/dio.dart';
import 'package:shopping_flutter_app/features/home/data/datasource/home_data_source.dart';
import 'package:shopping_flutter_app/features/home/domain/repositories/home_repositories.dart';

import '../../../../core/network/local/local_storage.dart';
import '../../domain/entities/product_entity.dart';

class HomeRepoImpl extends HomeRepositories {
  final HomeDataSource homeDataSource;

  final LocalStorage localStorage;


  HomeRepoImpl(this.homeDataSource, this.localStorage);

  @override
  Future<Response> getAllProducts() {
    return homeDataSource.getAllProducts();
  }

  @override
  Future<void> onAddCart(int userId, ProductData product,
      bool isIncrease) async {
    await localStorage.updateProductQuantity(userId, product, isIncrease);
  }

}
