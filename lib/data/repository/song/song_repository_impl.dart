import 'package:dartz/dartz.dart';
import 'package:flutter_pinku_app/data/data_sources/song/song_firebase_servise.dart';
import 'package:flutter_pinku_app/domain/repository/song/song.dart';
import 'package:flutter_pinku_app/service_locator.dart';

class SongRepositoryImpl extends SongRepository {
  @override
  Future<Either> getNewsSongs() async{
   return await sl<SongFirebaseServise>().getNewsSongs();
  }
  
  @override
  Future<Either> getPlayList() async {
    return await sl<SongFirebaseServise>().getPlayList();
  }
  
}