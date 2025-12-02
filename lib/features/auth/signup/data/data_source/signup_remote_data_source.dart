import 'package:dio/dio.dart';
import 'package:shopping_flutter_app/core/network/remote/api_client.dart';
import 'package:shopping_flutter_app/features/auth/login/data/models_DTOs/user_model.dart';

abstract class SignupRemoteData {
  Future<Response> signup(UserModel user);
}

class SignupRemoteDataImpl extends SignupRemoteData {
  final ApiClient dio;

  SignupRemoteDataImpl(this.dio);


  @override
  Future<Response> signup(UserModel user) async {
    final response = await dio.post("/users", user.toJson(),);
    // print("Response status: ${response.statusCode}");

    return response;
  }
}
