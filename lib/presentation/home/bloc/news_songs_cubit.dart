
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pinku_app/domain/usecases/song/get_news_songs.dart';
import 'package:flutter_pinku_app/presentation/home/bloc/news_songs_state.dart';
import 'package:flutter_pinku_app/service_locator.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {
  
  //NewsSongsCubit(super.initialState);
  NewsSongsCubit() : super(NewsSongsLoading());

  Future<void> getNewsSongs() async {
    var  returnedSongs = await sl<GetNewsSongsUsecase>().call();

    return returnedSongs.fold(
      (failure) {
        emit(NewsSongsLoadFailure());
        
      },
      (songs) {
        emit(NewsSongsLoaded(songs: songs));
      },
    );
  }
}