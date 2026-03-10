import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pinku_app/domain/entities/song/song.dart';
import 'package:flutter_pinku_app/domain/usecases/song/get_favorite_songs.dart';
import 'package:flutter_pinku_app/presentation/profile/bloc/favorite_songs_state.dart';
import 'package:flutter_pinku_app/service_locator.dart';

class FavoriteSongsCubit extends Cubit<FavoriteSongsState> {
  FavoriteSongsCubit(): super(FavoriteSongsLoading());

  List<SongEntity> favoriteSongs = [];

  Future<void> getFavoriteSongs() async{
      var result = await sl<GetFavoriteSongsUsecase>().call();

      result.fold(
        (l) {
          emit(FavoriteSongsFailure());
        }, 
        (r) {
          favoriteSongs = r;
          emit(FavoriteSongsLoaded(favoriteSongs: favoriteSongs));
        },);
  }
}