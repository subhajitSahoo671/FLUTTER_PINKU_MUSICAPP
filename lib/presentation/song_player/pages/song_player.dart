
// import 'dart:developer';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pinku_app/core/configs/theme/app_colors.dart';
import 'package:flutter_pinku_app/core/services/my_audio_handler.dart';
// import 'package:flutter_pinku_app/domain/entities/song/song.dart';
// import 'package:flutter_pinku_app/presentation/song_player/bloc/song_player_cubit.dart';
//import 'package:flutter_pinku_app/presentation/song_player/bloc/song_player_state.dart';
// import 'package:flutter_pinku_app/core/configs/theme/app_colors.dart';

class SongPlayerPage extends StatelessWidget {
  final MediaItem item;
  
  final int index;
  
  final MyAudioHandler audioHandler;
  
  const SongPlayerPage({super.key, required this.item,required this.index, required this.audioHandler});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Now Playing',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu_open_rounded, size: 25),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 16),
        ),
        backgroundColor: AppColors.gradient_1,
        elevation: 0,
      ),
      body: _PlayerContent(item: item, audioHandler: audioHandler),
    );
  }
}

class _PlayerContent extends StatelessWidget {
  final MediaItem item;
  final MyAudioHandler audioHandler;

  const _PlayerContent({required this.item, required this.audioHandler});

  @override
  Widget build(BuildContext context) {
    return Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          color: AppColors.gradient_1,
          child: StreamBuilder<MediaItem?>(
            stream: audioHandler.mediaItem,
            builder: (context, itemSnapshot) {

              if (itemSnapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              return Stack(
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.white, Color(0xFF7C007E)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                      child: Column(
                        children: [
                          //SizedBox(height: 40),
                          _songCover(context, itemSnapshot.data!),
                          SizedBox(height: 30),
                          _songDetails(itemSnapshot.data!),
                          SizedBox(height: 70),
                          songTools(context),
                          SizedBox(height: 50),
                          _songSlider(context, itemSnapshot.data!), 
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _songPlayer(context),
                  ),
                ],
              );
            }
          ),
        );
  }

  Widget _songCover(BuildContext context, MediaItem itemSnapshot) {
    return Container(
      height: MediaQuery.of(context).size.width / 1.4,
      width: MediaQuery.of(context).size.width / 1.4,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(itemSnapshot.artUri.toString()),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _songDetails( MediaItem itemSnapshot) {
    return Column(
      children: [
        Text(
          itemSnapshot.title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          itemSnapshot.artist ?? 'Unknown Artist',
          style: TextStyle(
            color: Colors.pinkAccent.shade700,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget songTools(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: 40,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite_rounded,
              color: Colors.pinkAccent.shade700,
              size: 30,
            ),
          ),
          VerticalDivider(
            width: 3,
            color: Colors.pinkAccent.shade700,
            thickness: 2,
            indent: 10,
            radius: BorderRadius.circular(30),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.queue_music_rounded,
              size: 32,
              color: Colors.white70,
            ),
          ),
          VerticalDivider(
            width: 3,
            color: Colors.pinkAccent.shade700,
            thickness: 2,
            indent: 10,
            radius: BorderRadius.circular(30),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.share,
              color: Colors.pinkAccent.shade700,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _songSlider(BuildContext context, MediaItem itemSnapshot) {

        return StreamBuilder<Duration>(
          stream: AudioService.position,
          builder: (context, positionSnap) {
            final position = positionSnap.data ?? Duration.zero;     
          // log(positionSnap.data.toString());
           
            final total = itemSnapshot.duration ?? Duration.zero;
            // Avoid division by zero when duration is zero.
            final maxSeconds = total.inSeconds > 0 ? total.inSeconds.toDouble() : 1.0;
            final value = position.inSeconds.toDouble().clamp(0.0, maxSeconds);

            return Column(
              children: [
                Slider(
                  value: value,
                  min: 0.0,
                  max: maxSeconds,
                 // divisions: value.toInt() > 0 ? value.toInt() : null,
                  onChanged: (v) {
                    audioHandler.seek(Duration(seconds: v.toInt()));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(formatDuration(position)),
                      Text(formatDuration(total)),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}';
  }

  Widget _songPlayer(BuildContext context) {
    return StreamBuilder<PlaybackState>(
      stream: audioHandler.playbackState.stream,
      builder: (context, snapshot) {
        bool playing = snapshot.data?.playing ?? false;
       // log("Playing state: $snapshot.data");
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            gradient: LinearGradient(
              colors: [AppColors.gradient_1, AppColors.gradient_2],
              begin: AlignmentGeometry.topLeft,
              end: AlignmentGeometry.bottomRight,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  audioHandler.skipToPrevious();
                },
                icon: Icon(
                  size: 35,
                  color: Colors.white,
                  Icons.skip_previous_rounded,
                ),
              ),
              SizedBox(width: 30),
              VerticalDivider(
                width: 3,
                color: Colors.white,
                indent: 30,
                endIndent: 30,
                thickness: 1,
                radius: BorderRadius.circular(30),
              ),
              SizedBox(width: 30),
              IconButton(
                onPressed: () {
                  if (playing) {
                    audioHandler.pause();
                  } else {
                    audioHandler.play();
                  }
                },
                icon: Icon(
                  size: 40,
                  color: Colors.white,
                  playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
                ),
              ),
              SizedBox(width: 30),
              VerticalDivider(
                width: 3,
                color: Colors.white,
                indent: 30,
                endIndent: 30,
                thickness: 1,
                radius: BorderRadius.circular(30),
              ),
              SizedBox(width: 30),  
              IconButton(
                onPressed: () {
                  audioHandler.skipToNext();
                },
                icon:
                    Icon(size: 35, color: Colors.white, Icons.skip_next_rounded),
              ),
            ],
          ),
        );
      },
    );
  }
}