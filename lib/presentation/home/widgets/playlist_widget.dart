// import 'dart:developer';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pinku_app/common/widgets/favorite_button/favorite_button.dart';
import 'package:flutter_pinku_app/core/services/my_audio_handler.dart';
// import 'package:flutter_pinku_app/common/helpers/is_dark_mode.dart';
import 'package:flutter_pinku_app/core/configs/theme/app_colors.dart';
import 'package:flutter_pinku_app/presentation/song_player/pages/song_player.dart';
import 'package:lottie/lottie.dart';

class PlaylistWidget extends StatelessWidget {
  final MediaItem songEntity;

  final int index;

  final MyAudioHandler audioHandler;

  const PlaylistWidget({
    super.key,
    required this.songEntity,
    required this.index,
    required this.audioHandler,
  });

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
                    return SongPlayerPage(
                      item: itemSnapshot.data!,
                      index: index,
                      audioHandler: audioHandler,
                    );
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
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: AppColors.greyText
                                .withBlue(50)
                                .withValues(alpha: 200),
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(songEntity.artUri.toString()),
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                songEntity.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: itemSnapshot.data!.id == songEntity.id
                                      ? Colors.purpleAccent.shade700.withGreen(
                                          110,
                                        )
                                      : null,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  // color: Colors.white
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                songEntity.artist.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  // color: Colors.white
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                     SizedBox(width: 25,),
                  Expanded(
                    flex: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        itemSnapshot.data!.id == songEntity.id 
                        ? audioHandler.playbackState.value.playing 
                          ? Lottie.asset("assets/lotties/equalizer.json", width: 30, height: 30 , fit: BoxFit.cover, animate: true)
                          : Lottie.asset("assets/lotties/equalizer.json", width: 30, height: 30 , fit: BoxFit.cover, animate: false)
                        : Text(
                          "${songEntity.duration?.inMinutes}:${songEntity.duration?.inSeconds.remainder(60).toString().padLeft(2, '0') ?? "00"}",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        //SizedBox(width: 50),
                        itemSnapshot.data!.id == songEntity.id
                            ? IconButton.filledTonal(
                              // padding: EdgeInsets.all(-5),
                              onPressed: () {
                                if (audioHandler.playbackState.value.playing) {
                                  audioHandler.pause();
                                } else {
                                  audioHandler.play();
                                }
                              },
                              icon: Icon(
                                audioHandler.playbackState.value.playing
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                                color: Colors.purpleAccent.shade700.withGreen(110),
                              )
                            )
                       : FavoriteButton(songEntity: songEntity, color: Colors.purpleAccent.shade700.withGreen(100),)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
