import 'package:flutter/material.dart';
import 'package:rhythmix/models/search_song.dart';
import 'package:rhythmix/services/remote.dart';

class SearchProvider extends ChangeNotifier {
  SearchSong? _searchSongResult;
  bool _loading = true;

  bool get loading => _loading;
  SearchSong? get searchSongResult => _searchSongResult;

  void searchKeyword(String query) async {
    var result = await searchSong(query);
    _searchSongResult = result;
    _loading = false;
    notifyListeners();
  }
}
