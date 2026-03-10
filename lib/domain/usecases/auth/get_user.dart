import 'package:dartz/dartz.dart';
import 'package:flutter_pinku_app/core/usecase/usecase.dart';
// import 'package:flutter_pinku_app/domain/entities/auth/user.dart';
import 'package:flutter_pinku_app/domain/repository/auth/auth.dart';
import 'package:flutter_pinku_app/service_locator.dart';

class GetUserUseCase implements Usecase<Either,dynamic> {
  @override
  Future<Either> call({params}) async{
    return await sl<AuthRepository>().getUser();
  }

}