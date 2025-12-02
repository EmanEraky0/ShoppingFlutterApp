import 'package:dio/dio.dart';

abstract class LoginRepo {
  Future<Response> login(String id);
}
