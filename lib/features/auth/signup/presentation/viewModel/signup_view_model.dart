import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_flutter_app/features/auth/login/data/models_DTOs/user_model.dart';
import 'package:shopping_flutter_app/features/auth/signup/domain/usecase/signup_usecase.dart';

import '../../../../../core/network/local/local_storage.dart';
import '../../../../../core/utils/constants/ui_result.dart';

class SignupViewModel extends ChangeNotifier {
  final SignupUseCase signupUseCase;

  final LocalStorage _localStorage;
  SignupViewModel(this.signupUseCase, this._localStorage);
  UiResult<Response>? state;

  Future<void> signup(UserModel userModel) async {
    state = Loading();
    notifyListeners();
    try {
     final response= await  signupUseCase(userModel);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = UserModel.fromJson(response.data);
        _localStorage.saveUserSession(user.id);
        state = Success(response);
      } else {
        state = Error("Signup failed: ${response.statusMessage}");
      }
    } catch (e) {
      state = Error(e.toString());
    }
    notifyListeners();
  }
}
