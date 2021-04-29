import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/track.dart';

class FirestoreBackend {
  static const _users = 'users';
  static const _tracks = 'tracks';
  static const _title = 'title';
  static const _album = 'album';
  static const _artist = 'artist';
  static const _runtime = 'runtime';
  static const _isSelected = 'isSelected';
  static const _dateAdded = 'dateAdded';

  static Future<List<Track>> getTracks() async {
    List<Track> trackList = [];

    var query = await FirebaseFirestore.instance.collection(_tracks).get();

    query.docs.forEach((e) {
      var data = e.data();
      var track = Track(
        id: e.id,
        title: data[_title],
        artist: data[_artist],
        album: data[_album],
        runtime: data[_runtime],
        isSelected: data[_isSelected],
      );
      trackList.add(track);
    });

    return trackList;
  }

  static Future<List<Track>> getUserTracks(String userId) async {
    List<Track> trackList = [];

    var query = await FirebaseFirestore.instance
        .collection(_users)
        .doc(userId)
        .collection(_tracks)
        .get();

    query.docs.forEach((e) {
      var data = e.data();
      var track = Track(
        id: e.id,
        title: data[_title],
        artist: data[_artist],
        album: data[_album],
        runtime: data[_runtime],
        isSelected: data[_isSelected],
        dateAdded: DateTime.fromMillisecondsSinceEpoch(data[_dateAdded]),
      );
      trackList.add(track);
    });

    return trackList;
  }

  static Future<Track> insertUserTrack(String userId, Track track) async {
    var data = {
      _title: track.title,
      _artist: track.artist,
      _album: track.album,
      _runtime: track.runtime,
      _isSelected: false,
      _dateAdded: DateTime.now().millisecondsSinceEpoch,
    };
    var ref = await FirebaseFirestore.instance
        .collection(_users)
        .doc(userId)
        .collection(_tracks)
        .add(data);
    return track;
  }

  static Future<void> removeUserTrack(Track track, String userId) {
    return FirebaseFirestore.instance
        .collection(_users)
        .doc(userId)
        .collection(_tracks)
        .doc(track.id)
        .delete();
  }
}
