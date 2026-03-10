import 'package:dartz/dartz.dart';
import 'package:flutter_pinku_app/core/usecase/usecase.dart';
import 'package:flutter_pinku_app/domain/repository/song/song.dart';
import 'package:flutter_pinku_app/service_locator.dart';

class AddOrRemoveFavoriteSongsUseCase implements Usecase<Either, String> {
  @override
  Future<Either> call({String? params}) async{
   return await sl<SongRepository>().addOrRemoveFavoriteSongs(params!);
  }
    
}