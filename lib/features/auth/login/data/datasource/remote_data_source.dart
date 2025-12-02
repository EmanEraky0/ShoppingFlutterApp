import 'package:dio/dio.dart';
import '../../../../../core/network/remote/api_client.dart';

abstract class RemoteDataSource{
  Future<Response> login(String id);
}

class RemoteDataSourceImpl implements RemoteDataSource{
  final ApiClient dio;

  RemoteDataSourceImpl(this.dio);

  @override
  Future<Response> login(String id) async {

    return  await dio.get("users/$id");
  }

}
