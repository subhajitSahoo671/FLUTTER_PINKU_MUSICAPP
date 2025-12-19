import 'package:dartz/dartz.dart';
import 'package:flutter_pinku_app/data/data_sources/auth/auth_firebase_servise.dart';
import 'package:flutter_pinku_app/data/models/auth/create_user_req.dart';
import 'package:flutter_pinku_app/domain/repository/auth/auth.dart';
import 'package:flutter_pinku_app/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<void> signin() {
    throw UnimplementedError();
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    return await sl<AuthFirebaseServise>().signup(createUserReq);
  }

}