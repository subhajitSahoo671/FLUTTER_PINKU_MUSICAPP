import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pinku_app/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:flutter_pinku_app/domain/usecases/song/add_or_remove_favorite_songs.dart';
import 'package:flutter_pinku_app/service_locator.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState>{

  FavoriteButtonCubit(): super(FavoriteButtonInitial());

  void favoriteButtonUpdated(String songId) async{
    var result = await sl<AddOrRemoveFavoriteSongsUseCase>().call(
      params: songId
    );

    result.fold((l) {
      
    }, (r) {
      emit(
        FavoriteButtonUpdated(
          isFavorite: r
        )
      );
    },);
  }
}