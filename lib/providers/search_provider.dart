import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rhythmix/models/search_song.dart';
import 'package:rhythmix/services/base_remote_data_source.dart';
import 'package:rhythmix/services/firestore_remote_data_source.dart';

class SearchProvider extends ChangeNotifier {
  SearchResult? _searchSongResult;
  bool _loading = true;
  Timer? _debounce;
  Map<String, dynamic> _musicCollectionData = {};
  List _genreList = [];

  bool get loading => _loading;
  SearchResult? get searchSongResult => _searchSongResult;
  List get genreList => _genreList;

  SearchProvider() {
    loadGenreList();
  }

  searchKeyword(String query) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      _loading = true;
      notifyListeners();

      var result = await globalSearch(query);
      _searchSongResult = result;
      _loading = false;
      notifyListeners();
    });
  }

  loadGenreList() async {
    _musicCollectionData = await fetchMusicCollectionData();
    _genreList = _musicCollectionData["genres"];
    notifyListeners();
  }
}
