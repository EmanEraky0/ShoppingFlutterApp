import 'package:dio/dio.dart';

import '../entities/product_entity.dart';

abstract class HomeRepositories {
  Future<Response> getAllProducts();
  Future<void> onAddCart(  int userId, ProductData product, bool isIncrease);
}