import 'package:flutter/material.dart';
import 'package:rhythmix/models/search_song.dart';
import 'package:rhythmix/services/remote.dart';

class ArtistProvider extends ChangeNotifier {
  bool _isLoading = true;
  SearchSong? _artistSongs;

  bool get isLoading => _isLoading;
  SearchSong? get artistSongs => _artistSongs;

  loadArtistSongs(String artist) async {
    
    _isLoading = true;
    notifyListeners();

    SearchSong result = await searchSong(artist);
    _artistSongs = result;
    _isLoading = false;
    notifyListeners();
  }
}
