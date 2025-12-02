import 'package:shopping_flutter_app/features/auth/login/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.id, required super.username, required super.email, required super.password});


  Map<String, dynamic> toJson() => {
    "id" : id,
    "username": username,
    "email": email,
    "password": password,
  };
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'], username: json['username'],email : json['email'],password :json['password']);
  }
}
