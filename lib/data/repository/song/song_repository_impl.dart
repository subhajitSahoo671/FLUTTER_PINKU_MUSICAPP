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
  
  @override
  Future<Either> addOrRemoveFavoriteSongs(String songId) async {
      return await sl<SongFirebaseServise>().addOrRemoveFavoriteSongs(songId);
  }
  
  @override
  Future<bool> isFavoriteSong(String songId) async {
      return await sl<SongFirebaseServise>().isFavoriteSong(songId);
    
  }
  
  @override
  Future<Either> getUserFavoriteSongs() {
    return sl<SongFirebaseServise>().getUserFavoriteSongs();
  }
  
}