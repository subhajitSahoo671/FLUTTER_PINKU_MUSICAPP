

// import 'dart:developer';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pinku_app/core/services/my_audio_handler.dart';
import 'package:flutter_pinku_app/common/helpers/is_dark_mode.dart';
import 'package:flutter_pinku_app/core/configs/theme/app_colors.dart';
import 'package:flutter_pinku_app/presentation/song_player/pages/song_player.dart';


class PlaylistWidget extends StatelessWidget {

  final MediaItem songEntity;
  
  final int index;
  
  final MyAudioHandler audioHandler;

  const PlaylistWidget({super.key, required this.songEntity, required this.index, required this.audioHandler});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MediaItem?>(
      stream: audioHandler.mediaItem,
      builder: (context, itemSnapshot) {
        if (itemSnapshot.data != null) {
          // log(itemSnapshot.data.toString());
          return GestureDetector(
               onTap: () {
                if (itemSnapshot.data!.id != songEntity.id) {
                  audioHandler.skipToQueueItem(index);
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    traversalEdgeBehavior: TraversalEdgeBehavior.closedLoop,
                    builder: (context) {
                      return SongPlayerPage(item: itemSnapshot.data!,index: index,audioHandler: audioHandler,);
                    },
                  ),
                );
              },
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 17,
                        backgroundColor: AppColors.greyText
                            .withBlue(50)
                            .withValues(alpha: 200),
                        child: Icon(Icons.play_arrow_rounded,
                        size: 25,
                        color: context.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(songEntity.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              // color: Colors.white
                            ),),
                            SizedBox(height: 5,),
                            Text(songEntity.artist.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              // color: Colors.white
                            ),)
                          ],
                        ),
                      ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("${songEntity.duration?.inMinutes}:${songEntity.duration?.inSeconds.remainder(60).toString().padLeft(2, '0') ?? "00"}",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14
                          ),
                          ),
                           SizedBox(width: 50,),
                           Icon(Icons.favorite_border_rounded,
                          //  color: AppColors.greyText.withBlue(50).withValues(alpha: 100)
                          color: Colors.purpleAccent.shade700.withGreen(100),
                           )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
        }
        return SizedBox.shrink();
      }
    );
  }
}