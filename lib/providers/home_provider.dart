import 'package:flutter/material.dart';
import 'package:rhythmix/models/search_song.dart';
import 'package:rhythmix/services/remote.dart';
import 'package:rhythmix/utils/constants.dart';

class HomeProvider extends ChangeNotifier {
  bool _isLoading = true;
  List<SearchSong> _topAlbumSongs = [];
  List<SearchSong> _trendingSongs = [];

  bool get isLoading => _isLoading;
  List<SearchSong> get topAlbumSongs => _topAlbumSongs;
  List<SearchSong> get trendingSongs => _trendingSongs;

  HomeProvider() {
    loadTopAlbumSongs();
    loadTrendingSongs();
  }

  loadTopAlbumSongs() async {
    List<SearchSong> listOfAlbum = [];
    for (int i = 0; i < topAlbums.length; i++) {
      var album = await searchSong(topAlbums[i]);
      listOfAlbum.add(album);
    }
    _topAlbumSongs = listOfAlbum;
    notifyListeners();
  }

  loadTrendingSongs() async {
    List<SearchSong> listOfTrending = [];
    for (int i = 0; i < trendingSongsList.length; i++) {
      var song = await searchSong(trendingSongsList[i]);
      listOfTrending.add(song);
    }
    _trendingSongs = listOfTrending;
    _isLoading = false;
    notifyListeners();
  }
}
