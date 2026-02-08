// import 'dart:developer';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pinku_app/core/configs/theme/app_colors.dart';
import 'package:flutter_pinku_app/core/services/my_audio_handler.dart';
//import 'package:flutter_pinku_app/common/helpers/is_dark_mode.dart';
// import 'package:flutter_pinku_app/core/configs/constants/app_urls.dart';
// import 'package:flutter_pinku_app/domain/entities/song/song.dart';
import 'package:flutter_pinku_app/presentation/home/bloc/news_songs_cubit.dart';
import 'package:flutter_pinku_app/presentation/home/bloc/news_songs_state.dart';
import 'package:flutter_pinku_app/presentation/song_player/pages/song_player.dart';

class NewsSongs extends StatelessWidget {
  final MyAudioHandler audioHandler;
  const NewsSongs({super.key, required this.audioHandler});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsSongsCubit()..getNewsSongs(),
      child: Align(
        alignment: AlignmentGeometry.bottomCenter,
        child: SizedBox(
          height: 250,
          child: BlocBuilder<NewsSongsCubit, NewsSongsState>(
            builder: (context, state) {
              if (state is NewsSongsLoading) {
                return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              if (state is NewsSongsLoaded) {
                return FutureBuilder<List<MediaItem>>(
                  future: state.getMediaItems(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator.adaptive());
                    }
                    if (snapshot.hasData && snapshot.data != null) {
                      return _songs(snapshot.data!);
                    }
                    return SizedBox.shrink();
                  },
                );
              }

              return Text('Error loading songs');
            },
          ),
        ),
      ),
    );
  }

  Widget _songs(List<MediaItem> songs) {
    // log(songs[0].imageURL);
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: songs.length,
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(width: 15);
      },
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return StreamBuilder<MediaItem?>(stream: audioHandler.mediaItem, builder: (context, snapshot) {
          if (snapshot.data != null) {
            GestureDetector(
          onTap: () {
              if (snapshot.data!.id != songs[index].id) {
                  audioHandler.skipToQueueItem(index);
                }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SongPlayerPage(item: snapshot.data!,audioHandler: audioHandler,index: index);
                },
              ),
            );
          },
          child: SizedBox(
            width: 135,
            height: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(songs[index].artUri.toString()),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 32,
                      width: 32,
                      transform: Matrix4.translationValues(-10, 10, 0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.greyText
                            .withBlue(50)
                            .withValues(alpha: 200),
                      ),
                      child: Icon(Icons.play_arrow_rounded, size: 22),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  songs[index].title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    // color: Colors.white
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  songs[index].artist!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    // color: Colors.white
                  ),
                ),
              ],
            ),
          ),
        );
          }
          return SizedBox.shrink();
        },);
      },
    );
  }
}
