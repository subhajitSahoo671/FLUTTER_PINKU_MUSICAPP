import 'package:flutter_pinku_app/data/data_sources/auth/auth_firebase_servise.dart';
import 'package:flutter_pinku_app/data/data_sources/song/song_firebase_servise.dart';
import 'package:flutter_pinku_app/data/repository/auth/auth_repository_impl.dart';
import 'package:flutter_pinku_app/data/repository/song/song_repository_impl.dart';
import 'package:flutter_pinku_app/domain/repository/auth/auth.dart';
import 'package:flutter_pinku_app/domain/repository/song/song.dart';
import 'package:flutter_pinku_app/domain/usecases/auth/get_user.dart';
import 'package:flutter_pinku_app/domain/usecases/auth/signin.dart';
import 'package:flutter_pinku_app/domain/usecases/auth/signup.dart';
import 'package:flutter_pinku_app/domain/usecases/song/add_or_remove_favorite_songs.dart';
import 'package:flutter_pinku_app/domain/usecases/song/get_favorite_songs.dart';
import 'package:flutter_pinku_app/domain/usecases/song/get_news_songs.dart';
import 'package:flutter_pinku_app/domain/usecases/song/get_play_list.dart';
import 'package:flutter_pinku_app/domain/usecases/song/is_favorite_song.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
   
   sl.registerSingleton<AuthFirebaseServise>(
    AuthFirebaseServiseImpl()
   );

   sl.registerSingleton<SongFirebaseServise>(
    SongFirebaseServiseImpl()
   );

    sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl()
   );

   sl.registerSingleton<SongRepository>(
    SongRepositoryImpl()
   );

    sl.registerSingleton<SignupUseCase>(
    SignupUseCase()
   );

    sl.registerSingleton<SigninUseCase>(
    SigninUseCase()
   );

   sl.registerSingleton<GetNewsSongsUsecase>(
    GetNewsSongsUsecase()
   );

   sl.registerSingleton<GetPlayListUsecase>(
    GetPlayListUsecase()
   );

   sl.registerSingleton<AddOrRemoveFavoriteSongsUseCase>(
    AddOrRemoveFavoriteSongsUseCase()
   );

   sl.registerSingleton<IsFavoriteSongUseCase>(
    IsFavoriteSongUseCase()
    );
    
    sl.registerSingleton<GetUserUseCase>(
    GetUserUseCase()
   );

   sl.registerSingleton<GetFavoriteSongsUsecase>(
    GetFavoriteSongsUsecase()
   );
}