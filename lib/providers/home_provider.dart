import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhythmix/models/search_song.dart';
import 'package:rhythmix/services/remote.dart';
import 'package:rhythmix/utils/constants.dart';

class HomeProvider extends ChangeNotifier {
  bool _isLoading = true;
  List<SearchSong> _topAlbumSongs = [];

  bool get isLoading => _isLoading;
  List<SearchSong> get topAlbumSongs => _topAlbumSongs;

  HomeProvider() {
    loadTopAlbumSongs();
  }

  loadTopAlbumSongs() async {
    List<SearchSong> listOfAlbum = [];
    for (int i = 0; i < topAlbums.length; i++) {
      var albums = await searchSong(topAlbums[i]);
      listOfAlbum.add(albums);
    }
    _topAlbumSongs = listOfAlbum;
    _isLoading = false;
    notifyListeners();
  }
}
