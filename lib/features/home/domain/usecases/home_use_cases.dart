import 'package:shopping_flutter_app/features/home/domain/entities/product_entity.dart';
import 'package:shopping_flutter_app/features/home/domain/repositories/home_repositories.dart';
import '../../../../core/utils/constants/ui_result.dart';
import '../../data/dto_model/product_model.dart';


class HomeUseCases {
  final HomeRepositories homeRepositories;

  HomeUseCases(this.homeRepositories);

  Future<UiResult<List<ProductData>>> call() async {
  final response =  await homeRepositories.getAllProducts();
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = response.data;
      final products = jsonList.map((e) => ProductDto.fromJson(e)).toList();
      return Success(products);
    } else {
      return Error('Failed to load products');
    }

  }

  Future<void> onAddCart( int userId, ProductData product, bool isIncrease) async {
    await homeRepositories.onAddCart(userId, product, isIncrease);
  }


}