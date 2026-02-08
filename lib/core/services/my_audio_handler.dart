import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class MyAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler{

  AudioPlayer audioPlayer=AudioPlayer();
  
  UriAudioSource _createAudioSource(MediaItem item){
    return ProgressiveAudioSource(Uri.parse(item.id));
  }

  void _listenForCurrentSongIndexChanges(){
    audioPlayer.currentIndexStream.listen((index) {
      final playlist = queue.value;
      if(index != null && playlist.length > index){
        mediaItem.add(playlist[index]);
      } 
    });
  }

  //boardcast the current playback state of the audio player based on the received playbackevent
  
  void _boardcastState(PlaybackEvent event){
    playbackState.add(
      playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          if(audioPlayer.playing) MediaControl.pause else MediaControl.play,
          // MediaControl.stop,
          MediaControl.skipToNext,
        ],
        systemActions: {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
        },
        androidCompactActionIndices: const [0,1,3],
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[audioPlayer.processingState]!,
        playing: audioPlayer.playing,
        updatePosition: audioPlayer.position,
        bufferedPosition: audioPlayer.bufferedPosition,
        speed: audioPlayer.speed,
        queueIndex: event.currentIndex,
      )
    );
  }

   // function to initialize the audio player with a list of songs
  Future<void> initSongs({required List<MediaItem> songs}) async{
    audioPlayer.playbackEventStream.listen(_boardcastState);
    
    final audioSource = songs.map(_createAudioSource).toList();

    await audioPlayer.setAudioSources(audioSource);

    //add the songs to the queue
    final newQueue = queue.value..addAll(songs);  
    queue.add(newQueue);

    //listen for changes in the current song index
    _listenForCurrentSongIndexChanges();

  // Handle completion of a song to automatically skip to the next one
    audioPlayer.processingStateStream.listen((state) {
      if(state == ProcessingState.completed){
        skipToNext();
      }
    });
  }

  //play fuction to start playback
  @override
  Future<void> play() => audioPlayer.play();

  //pause function to pause playback
  @override
  Future<void> pause() => audioPlayer.pause();

  @override
  Future<void> seek(Duration position) => audioPlayer.seek(position);

  //skip to a specific song in the queue and start playback
  @override
  Future<void> skipToQueueItem(int index) async{
    if(index < 0 || index >= queue.value.length) return;
    await audioPlayer.seek(Duration.zero, index: index);
    play();
  }

  //skip to the next song in the queue
  @override
  Future<void> skipToNext() => audioPlayer.seekToNext();

  //skip to the previous song in the queue
  @override
  Future<void> skipToPrevious() => audioPlayer.seekToPrevious();
}