import 'package:dartz/dartz.dart';
import 'package:flutter_pinku_app/core/usecase/usecase.dart';
import 'package:flutter_pinku_app/domain/repository/song/song.dart';
import 'package:flutter_pinku_app/service_locator.dart';

class GetFavoriteSongsUsecase implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) async{
   return await sl<SongRepository>().getUserFavoriteSongs();
  }
    
}