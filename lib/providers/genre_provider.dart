import 'package:flutter/material.dart';
import 'package:rhythmix/models/search_song.dart';
import 'package:rhythmix/services/remote.dart';

class GenreProvider extends ChangeNotifier {
  bool _isLoading = true;
  SearchResult? _genreSongs;

  bool get isLoading => _isLoading;
  SearchResult? get genreSongs => _genreSongs;

  loadGenreSongs(String genre) async {
    
    _isLoading = true;
    notifyListeners();

    SearchResult result = await searchGenre(genre);
    _genreSongs = result;
    _isLoading = false;
    notifyListeners();
  }
}
