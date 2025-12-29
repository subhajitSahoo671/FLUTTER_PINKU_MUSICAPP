


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_pinku_app/domain/entities/song/song.dart';

class SongModel {
   String? title;
   String? artist;
   num? duration; 
   Timestamp? releaseDate;
    String? imageURL;
    String? songURL;

  SongModel({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
    required this.imageURL,
    required this.songURL,
  });

   SongModel.fromMap(Map<String, dynamic> data) {
   
      title = data['title'];
      artist = data['artist'];
      duration = data['duration'];
      releaseDate = data['releaseDate'];
      imageURL = data['imageURL'];
      songURL = data['songURL'];
    
  }
}

extension SongModelX on SongModel {

  SongEntity toEntity() {
    // log(imageURL.toString());
    return SongEntity(title: title!, artist: artist!, duration: duration!, releaseDate: releaseDate!, imageURL: imageURL!, songURL: songURL!);
  }
}