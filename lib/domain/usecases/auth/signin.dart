import 'package:dartz/dartz.dart';
import 'package:flutter_pinku_app/core/usecase/usecase.dart';
import 'package:flutter_pinku_app/data/models/auth/signin_user_req.dart';
import 'package:flutter_pinku_app/domain/repository/auth/auth.dart';
import 'package:flutter_pinku_app/service_locator.dart';

class SigninUseCase implements Usecase<Either,SigninUserReq> {
  @override
  Future<Either> call({SigninUserReq? params}) async{
    return await sl<AuthRepository>().signin( params!);
  }

}