import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pinku_app/core/configs/theme/app_colors.dart';
import 'package:flutter_pinku_app/domain/entities/song/song.dart';
import 'package:flutter_pinku_app/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:flutter_pinku_app/presentation/song_player/bloc/song_player_state.dart';
// import 'package:flutter_pinku_app/core/configs/theme/app_colors.dart';

class SongPlayerPage extends StatelessWidget {
  final SongEntity songEntity;
  const SongPlayerPage({super.key, required this.songEntity});

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
      body: BlocProvider(
        create: (context) => SongPlayerCubit()..loadSong(songEntity.songURL),
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          color: AppColors.gradient_1,
          child: Stack(
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
                      _songCover(context),
                      SizedBox(height: 20),
                      _songDetails(),
                      SizedBox(height: 60),
                      songTools(context),
                      SizedBox(height: 40),
                      _songSlider(context),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: _songPlayer(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 1.4,
      width: MediaQuery.of(context).size.width / 1.4,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(songEntity.imageURL),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _songDetails() {
    return Column(
      children: [
        Text(
          songEntity.title,
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          songEntity.artist,
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

  Widget _songSlider(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoading) {
          // var id = context.read<SongPlayerCubit>().songDuration.toString();
          // log(id);
          // log(songEntity.duration.toString());
          return CircularProgressIndicator.adaptive();
        }
        if (state is SongPlayerLoaded) {
          return Column(
            children: [
              Slider(
                value: context
                    .read<SongPlayerCubit>()
                    .songPosition
                    .inSeconds
                    .toDouble(),
                min: 0.0,
                max: context
                    .read<SongPlayerCubit>()
                    .songDuration
                    .inSeconds
                    .toDouble(),
                onChanged: (value) {},
              ),
              // SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatDuration(
                        context.read<SongPlayerCubit>().songPosition,
                      ),
                    ),
                    Text(
                      formatDuration(
                        context.read<SongPlayerCubit>().songDuration,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        return Container();
      },
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}';
  }

  Widget _songPlayer(BuildContext context) {
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
            onPressed: () {},
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
          BlocBuilder<SongPlayerCubit, SongPlayerState>(
            builder: (context, state) {
              if (state is SongPlayerLoaded) {
                return IconButton(
                  onPressed: () {
                    context.read<SongPlayerCubit>().playOrPauseSong();
                  },
                  icon: Icon(
                    size: 40,
                    color: Colors.white,
                    context.read<SongPlayerCubit>().audioPlayer.playing
                        ? Icons.pause
                        : Icons.play_arrow_rounded,
                  ),
                );
              }

              return Icon(
                size: 40,
                color: Colors.white,
                Icons.play_arrow_rounded,
              );
            },
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
            onPressed: () {},
            icon: Icon(size: 35, color: Colors.white, Icons.skip_next_rounded),
          ),
        ],
      ),
    );
  }
}
