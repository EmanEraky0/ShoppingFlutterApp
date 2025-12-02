import 'package:dio/dio.dart';
import 'package:shopping_flutter_app/features/auth/login/domain/repositories/login_repo.dart';

class LoginUserUseCase {
  final LoginRepo repo;
  LoginUserUseCase(this.repo);

  Future<Response> call(String id){
   return repo.login(id);
  }

}