import 'package:flutter/foundation.dart';

class Track implements Comparable {
  bool isSelected;
  final String title;
  final String artist;
  final String album;
  final int runtime;
  final String id;

  DateTime _dateAdded;
  DateTime get dateAdded => _dateAdded;

  Track({
    @required this.id,
    this.title = '',
    this.artist = '',
    this.album = '',
    this.runtime = 0,
    this.isSelected = false,
    dateAdded,
  }) {
    assert(title != null);
    // If createDate is null, assign it the value of Jan 1, 2021
    _dateAdded = dateAdded ?? DateTime(2021);
  }

  int compareToTitle(other) {
    if (other is Track) {
      return title.compareTo(other.title);
    }
    return -1;
  }

  int compareToArtist(other) {
    if (other is Track) {
      return artist.compareTo(other.artist);
    }
    return -1;
  }
  int compareToAlbum(other) {
    if (other is Track) {
      return album.compareTo(other.album);
    }
    return -1;
  }
  int compareToRuntime(other) {
    if (other is Track) {
      return runtime.compareTo(other.runtime);
    }
    return -1;
  }

  @override
  int compareTo(other) {
    if (other is Track) {
      return dateAdded.compareTo(other.dateAdded);
    }
    return -1;
  }
}
