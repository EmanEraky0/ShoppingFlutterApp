import 'package:dio/dio.dart';
import '../../../../core/network/remote/api_client.dart';


abstract class HomeDataSource {
  Future<Response> getAllProducts();
}

class HomeDataSourceImpl extends HomeDataSource {
  final ApiClient dio;

  HomeDataSourceImpl(this.dio);

  @override
  Future<Response> getAllProducts() async {
    return await dio.get('products');
  }
}
