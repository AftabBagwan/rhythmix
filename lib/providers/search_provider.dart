import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rhythmix/models/search_song.dart';
import 'package:rhythmix/services/base_remote_data_source.dart';

class SearchProvider extends ChangeNotifier {
  SearchResult? _searchSongResult;
  bool _loading = true;
   Timer? _debounce;

  bool get loading => _loading;
  SearchResult? get searchSongResult => _searchSongResult;

  void searchKeyword(String query) async {
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
}
