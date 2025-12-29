// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pinku_app/core/configs/theme/app_colors.dart';
//import 'package:flutter_pinku_app/common/helpers/is_dark_mode.dart';
// import 'package:flutter_pinku_app/core/configs/constants/app_urls.dart';
import 'package:flutter_pinku_app/domain/entities/song/song.dart';
import 'package:flutter_pinku_app/presentation/home/bloc/news_songs_cubit.dart';
import 'package:flutter_pinku_app/presentation/home/bloc/news_songs_state.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsSongsCubit()..getNewsSongs(),
      child: Align(
        alignment: AlignmentGeometry.bottomCenter,
        child: SizedBox(
          height: 250,
          child: BlocBuilder<NewsSongsCubit,NewsSongsState>(
            builder: (context, state) {
              if (state is NewsSongsLoading) {
                return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator.adaptive());
              }
              if (state is NewsSongsLoaded) {
                return _songs(state.songs);
              }
        
              return Text('Error loading songs');
            },
          
          )
         
        ),
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {

    // log(songs[0].imageURL);
    return  ListView.separated(
      scrollDirection: Axis.horizontal,
          itemCount: songs.length,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(width: 15,);
          },
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: 140,
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
                      image: NetworkImage(
                        songs[index].imageURL
                      )    
                    )
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 35,
                      width: 35,
                      transform: Matrix4.translationValues(-10, 10, 0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.greyText.withBlue(50).withValues(alpha: 200),
                      ),
                      child: Icon(
                        Icons.play_arrow_rounded
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  songs[index].title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    // color: Colors.white
                  ),
                ),
                SizedBox(height: 5,),
                Text(
                  songs[index].artist,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    // color: Colors.white
                  ),
                ),
              ],
                            ),
            );
          },
        );
  }
}
