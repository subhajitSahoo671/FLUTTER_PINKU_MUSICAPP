import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pinku_app/common/helpers/is_dark_mode.dart';
import 'package:flutter_pinku_app/common/widgets/button/basic_app_bar.dart';
import 'package:flutter_pinku_app/core/configs/theme/app_colors.dart';
import 'package:flutter_pinku_app/core/services/my_audio_handler.dart';
import 'package:flutter_pinku_app/presentation/home/widgets/playlist_widget.dart';
import 'package:flutter_pinku_app/presentation/profile/bloc/favorite_songs_cubit.dart';
import 'package:flutter_pinku_app/presentation/profile/bloc/favorite_songs_state.dart';
import 'package:flutter_pinku_app/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:flutter_pinku_app/presentation/profile/bloc/profile_info_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.audioHandler});

  final MyAudioHandler audioHandler;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: Text('Profile'),
        action: IconButton(
          onPressed: () {},
          icon: FaIcon(FontAwesomeIcons.ellipsisVertical, size: 22),
        ),
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        color: AppColors.primary.withValues(alpha: 0.8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _profileInfo(context),
              SizedBox(height: 30),
              _favoriteSongs(audioHandler, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Container(
        height: MediaQuery.sizeOf(context).height / 4.2,
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
          builder: (context, state) {
            if (state is ProfileInfoLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is ProfileInfoLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 47,
                    backgroundImage: NetworkImage(state.userEntity.imageURL!),
                  ),
                  SizedBox(height: 15),
                  Text(
                    state.userEntity.email!,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 10),
                  Text(
                    state.userEntity.fullName!,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                ],
              );
            }

            if (state is ProfileInfoFailure) {
              return Center(child: Text('Please try again later'));
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _favoriteSongs(audioHandler,BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteSongsCubit()..getFavoriteSongs(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "FAVORITE SONGS",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.lightBackground,
              ),
            ),
              SizedBox(height: 15),
            SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height - (MediaQuery.sizeOf(context).height / 4.2)  - (kToolbarHeight * 2) - 50,
                  width: double.infinity,
                child: BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
                  builder: (context, state) {
                    if (state is FavoriteSongsLoading) {
                      return Center(child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator.adaptive(),
                          SizedBox(height: 100,)
                        ],
                      ));
                    }
                            
                    if (state is FavoriteSongsLoaded) {
                      return FutureBuilder<List<MediaItem>>(
                        future: state.getMediaItems(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator.adaptive(),
                                  SizedBox(height: 100,)
                                ],
                              ),
                            );
                          }
                          if (snapshot.hasData && snapshot.data != null) {
                            return ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              separatorBuilder: (BuildContext context, int index) {
                                return SizedBox(height: 17);
                              },
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return PlaylistWidget(
                                  function: () {
                                    context.read<FavoriteSongsCubit>().removeSong(index);
                                  },
                                  songEntity: snapshot.data![index],
                                  index: index,
                                  audioHandler: audioHandler,
                                  isFavorite: true,
                                  activeColor : Colors.pink.shade900,
                                  textColor : AppColors.lightBackground
                                );
                              },
                            );
                          }
                          return Container();
                        },
                      );
                    }
                            
                    if (state is FavoriteSongsFailure) {
                      return Text("Please try again");
                    }
                            
                    return Container();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
