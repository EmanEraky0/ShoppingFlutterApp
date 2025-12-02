import 'package:dio/dio.dart';
import 'package:shopping_flutter_app/features/auth/login/data/datasource/remote_data_source.dart';
import 'package:shopping_flutter_app/features/auth/login/domain/repositories/login_repo.dart';

class LoginRepoImpl extends LoginRepo{
  final RemoteDataSource remoteDataSource ;

  LoginRepoImpl(this.remoteDataSource);

  @override
  Future<Response> login(String id) async {
   return remoteDataSource.login(id);
  }
  
}