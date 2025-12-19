import 'package:flutter_pinku_app/data/data_sources/auth/auth_firebase_servise.dart';
import 'package:flutter_pinku_app/data/repository/auth/auth_repository_impl.dart';
import 'package:flutter_pinku_app/domain/repository/auth/auth.dart';
import 'package:flutter_pinku_app/domain/usecases/auth/signup.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
   
   sl.registerSingleton<AuthFirebaseServise>(
    AuthFirebaseServiseImpl()
   );

    sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl()
   );

    sl.registerSingleton<SignupUseCase>(
    SignupUseCase()
   );
}