import 'package:flutter/material.dart';
import 'package:rhythmix/models/song.dart';
import 'package:rhythmix/services/remote.dart';
import 'package:rhythmix/utils/constants.dart';

class HomeProvider extends ChangeNotifier {
  bool _isLoading = true;
  List<List<Song>> _topAlbumSongs = [];
  List<Song> _trendingSongs = [];

  bool get isLoading => _isLoading;
  List<List<Song>> get topAlbumSongs => _topAlbumSongs;
  List<Song> get trendingSongs => _trendingSongs;

  HomeProvider() {
    loadTopAlbumSongs();
    loadTrendingSongs();
  }

  loadTopAlbumSongs() async {
    List<List<Song>> listOfAlbum = [];
    for (int i = 0; i < topAlbums.length; i++) {
      var album = await searchSong(topAlbums[i]);
      listOfAlbum.add(album.data.songs);
    }
    _topAlbumSongs = listOfAlbum;
    notifyListeners();
  }

  loadTrendingSongs() async {
    List<Song> listOfTrending = [];
    for (int i = 0; i < trendingSongsList.length; i++) {
      var songs = await searchSong(trendingSongsList[i]);
      listOfTrending.add(songs.data.songs[0]);
    }
    _trendingSongs = listOfTrending;
    _isLoading = false;
    notifyListeners();
  }
}
