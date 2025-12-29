import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pinku_app/core/configs/theme/app_colors.dart';
import 'package:flutter_pinku_app/domain/entities/song/song.dart';
import 'package:flutter_pinku_app/presentation/home/bloc/play_list_cubit.dart';
import 'package:flutter_pinku_app/presentation/home/bloc/play_list_state.dart';

class PlayList extends StatelessWidget {
  const PlayList({super.key});

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
                _songs(state.songs),
              ],
            );
          }

          return Container();
        },
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
      itemCount: songs.length,
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 15);
      },
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 19,
              backgroundColor: AppColors.greyText
                  .withBlue(50)
                  .withValues(alpha: 200),
              child: Icon(Icons.play_arrow_rounded),
            ),
            SizedBox(width: 10,),
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(songs[index].title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    // color: Colors.white
                  ),),
                  SizedBox(height: 5,),
                  Text(songs[index].artist,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    // color: Colors.white
                  ),)
                ],
              ),
              ],
            ),
            Row(
              children: [
                Text(songs[index].duration.toString().replaceAll('.', ':'),
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
                ),
                 SizedBox(width: 40,),
                 Icon(Icons.favorite_border_rounded,
                //  color: AppColors.greyText.withBlue(50).withValues(alpha: 100)
                color: Colors.purpleAccent.shade700.withGreen(100),
                 )
              ],
            )
          ],
        );
      },
    );
  }
}
