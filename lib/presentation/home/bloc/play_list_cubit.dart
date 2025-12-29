
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pinku_app/domain/usecases/song/get_play_list.dart';
import 'package:flutter_pinku_app/presentation/home/bloc/play_list_state.dart';
import 'package:flutter_pinku_app/service_locator.dart';

class PlayListCubit extends Cubit<PlayListState> {
  
  //PlayListCubit(super.initialState);
  PlayListCubit() : super(PlayListLoading());

  Future<void> getPlayList() async {
    var  returnedSongs = await sl<GetPlayListUsecase>().call();

    return returnedSongs.fold(
      (failure) {
        emit(PlayListLoadFailure());
        
      },
      (songs) {
        emit(PlayListLoaded(songs: songs));
      },
    );
  }
}