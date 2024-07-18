import 'package:flutter/material.dart';
import 'package:rhythmix/models/search_song.dart';
import 'package:rhythmix/services/remote.dart';

class ArtistProvider extends ChangeNotifier {
  bool _isLoading = true;
  SearchResult? _artistSongs;

  bool get isLoading => _isLoading;
  SearchResult? get artistSongs => _artistSongs;

  loadArtistSongs(String artist) async {
    
    _isLoading = true;
    notifyListeners();

    SearchResult result = await searchArtist(artist);
    _artistSongs = result;
    _isLoading = false;
    notifyListeners();
  }
}
