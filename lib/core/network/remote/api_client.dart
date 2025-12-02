import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio = Dio(BaseOptions(baseUrl: "https://fakestoreapi.com/"));


  Future<Response> get(String path) async {
    return await dio.get(path);
  }
  Future<Response> post(String path, Map<String, dynamic> data) async {
    return await dio.post(path, data: data);
  }

}