//import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_pinku_app/data/models/song/song.dart';
import 'package:flutter_pinku_app/domain/entities/song/song.dart';

abstract class SongFirebaseServise {

  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  
}

class SongFirebaseServiseImpl extends SongFirebaseServise {
  @override

  Future<Either> getNewsSongs() async {
    
     try {
       
        List<SongEntity> songs = [];
    var data = await FirebaseFirestore.instance.collection('songs').orderBy('releaseDate', descending: true).limit(3).get();

    for (var doc in data.docs) {
     
     var songModel= SongModel.fromMap(doc.data());
     songs.add(
      songModel.toEntity()
      );
    }

    return right(songs);

     } on FirebaseException catch (e) {
      return left(e.message);
     }
  }
  
  @override
  Future<Either> getPlayList() async{
     try {
       
        List<SongEntity> songs = [];
    var data = await FirebaseFirestore.instance.collection('songs').orderBy('releaseDate', descending: true).get();

    for (var doc in data.docs) {
     
     var songModel= SongModel.fromMap(doc.data());
     songs.add(
      songModel.toEntity()
      );
    }

    return right(songs);

     } on FirebaseException catch (e) {
      return left(e.message);
     }
  }
}