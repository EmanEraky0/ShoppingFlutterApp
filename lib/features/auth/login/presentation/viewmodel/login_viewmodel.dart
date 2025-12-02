import 'package:flutter/cupertino.dart';
import 'package:shopping_flutter_app/features/auth/login/domain/usecases/login_user.dart';
import '../../../../../core/network/local/local_storage.dart';
import '../../../../../core/utils/constants/ui_result.dart';
import '../../data/models_DTOs/user_model.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginUserUseCase loginUser;

  final LocalStorage localStorage;

  LoginViewModel(this.loginUser, this.localStorage);

  UiResult<UserModel>? state;

  Future<void> login(String id) async {
    state = Loading();
    notifyListeners();
    try {
      final response = await loginUser(id);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = UserModel.fromJson(response.data);
        await localStorage.saveUserSession(user.id);
        state = Success(user);
      } else {
        state = Error(response.statusMessage.toString());
      }
    } catch (e) {
      Error(e.toString());
    }
    notifyListeners();
  }
}
