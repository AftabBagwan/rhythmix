import 'package:flutter/material.dart';
import 'package:rhythmix/models/search_song.dart';

class HomeProvider extends ChangeNotifier {
  bool _isLoading = true;
  List<SearchSong> _topAlbumSongs = [];

  bool get isLoading => _isLoading;
  List<SearchSong> get topAlbumSongs => _topAlbumSongs;

  loadTopAlbumSongs() async {
    List<SearchSong> listOfAlbum = [];
    for (int i = 0; i < topAlbums.length; i++) {
      var albums = await searchSong(topAlbums[i]);
      listOfAlbum.add(albums);
    }
    if (!mounted) return;
    setState(() {
      topAlbumSongs = listOfAlbum;
    });
  }
}
