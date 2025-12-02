import 'package:dio/dio.dart';

import '../../../login/data/models_DTOs/user_model.dart';

abstract class SignupRepo{
  Future<Response> signup(UserModel user);

}