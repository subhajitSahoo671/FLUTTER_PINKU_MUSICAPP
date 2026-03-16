import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pinku_app/domain/entities/song/song.dart';
import 'package:flutter_pinku_app/domain/usecases/song/get_favorite_songs.dart';
import 'package:flutter_pinku_app/presentation/profile/bloc/favorite_songs_state.dart';
import 'package:flutter_pinku_app/service_locator.dart';

class FavoriteSongsCubit extends Cubit<FavoriteSongsState> {
  FavoriteSongsCubit(): super(FavoriteSongsLoading());

  List<SongEntity> favoriteSongs = [];

  Future<void> getFavoriteSongs() async {
    try {
      final result = await sl<GetFavoriteSongsUsecase>().call();

      if (isClosed) return; // avoid emitting after disposal

      result.fold(
        (l) {
          if (!isClosed) emit(FavoriteSongsFailure());
        },
        (r) {
          favoriteSongs = r;
          if (!isClosed) emit(FavoriteSongsLoaded(favoriteSongs: favoriteSongs));
        },
      );
    } catch (e) {
      log(  'error: $e');
      if (!isClosed) emit(FavoriteSongsFailure());
    }
  }

  void removeSong(int index) {
    favoriteSongs.removeAt(index);
    if (!isClosed) emit(FavoriteSongsLoaded(favoriteSongs: favoriteSongs));
  }
}