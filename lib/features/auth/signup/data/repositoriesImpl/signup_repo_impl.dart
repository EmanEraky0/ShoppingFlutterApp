import 'package:dio/dio.dart';
import 'package:shopping_flutter_app/features/auth/login/data/models_DTOs/user_model.dart';
import 'package:shopping_flutter_app/features/auth/signup/data/data_source/signup_remote_data_source.dart';
import 'package:shopping_flutter_app/features/auth/signup/domain/repositories/signup_repo.dart';

class SignupRepoImpl extends SignupRepo{
  final SignupRemoteData remoteData;

  SignupRepoImpl(this.remoteData);

  @override
  Future<Response> signup(UserModel user) {
    return remoteData.signup(user);
  }

}