
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_pinku_app/common/helpers/is_dark_mode.dart';
// import 'package:flutter_pinku_app/core/configs/theme/app_colors.dart';
import 'package:flutter_pinku_app/core/services/my_audio_handler.dart';
// import 'package:flutter_pinku_app/domain/entities/song/song.dart';
import 'package:flutter_pinku_app/presentation/home/bloc/play_list_cubit.dart';
import 'package:flutter_pinku_app/presentation/home/bloc/play_list_state.dart';
import 'package:flutter_pinku_app/presentation/home/widgets/playlist_widget.dart';
// import 'package:flutter_pinku_app/presentation/song_player/pages/song_player.dart';

class PlayList extends StatelessWidget {
  final MyAudioHandler audioHandler;
  const PlayList({super.key, required this.audioHandler});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlayListCubit()..getPlayList(),
      child: BlocBuilder<PlayListCubit, PlayListState>(
        builder: (context, state) {
          if (state is PlayListLoading) {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is PlayListLoaded) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "PlayList",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    //Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text("See More", style: TextStyle(fontSize: 11)),
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                Flexible(
                  child: FutureBuilder<List<MediaItem>>(
                    future: state.getMediaItems(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator.adaptive());
                      }
                      if (snapshot.hasData && snapshot.data != null) {
                        return _songs(snapshot.data!);
                      }
                      return Container();
                    },
                  ),
                ),
              ],
            );
          }

          return Container();
        },
      ),
    );
  }

  Widget _songs(List<MediaItem> songs) {
    _audioHandlerInitsongs(songs);
    //log(songs.toString());
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemCount: songs.length,
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 17);
      },
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return PlaylistWidget(songEntity: songs[index], index: index, audioHandler: audioHandler);
      },
    );
  }

  Future<void> _audioHandlerInitsongs(List<MediaItem> songs) async {
   await audioHandler.initSongs(songs: songs);
  }

}