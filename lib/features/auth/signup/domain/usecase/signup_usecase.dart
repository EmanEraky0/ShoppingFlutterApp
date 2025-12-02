import 'package:dio/dio.dart';
import 'package:shopping_flutter_app/features/auth/login/data/models_DTOs/user_model.dart';
import 'package:shopping_flutter_app/features/auth/signup/domain/repositories/signup_repo.dart';

class SignupUseCase {
  final SignupRepo signupRepo;

  SignupUseCase(this.signupRepo);

  Future<Response> call(UserModel user) {
    return signupRepo.signup(user);
  }
}
