import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pinku_app/domain/usecases/auth/get_user.dart';
import 'package:flutter_pinku_app/presentation/profile/bloc/profile_info_state.dart';
import 'package:flutter_pinku_app/service_locator.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit() : super(ProfileInfoLoading());

  Future<void> getUser() async {
    final result = await sl<GetUserUseCase>().call();
    result.fold(
      (failure) => emit(ProfileInfoFailure()),
      (userEntity) => emit(ProfileInfoLoaded(userEntity: userEntity)),
    );
  }
}