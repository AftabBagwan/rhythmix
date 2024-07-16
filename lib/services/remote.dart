import 'dart:convert';

import 'package:rhythmix/models/search_song.dart';
import 'package:http/http.dart' as http;

Future<SearchSong> searchSong(String query) async {
  var response =
      await http.get(
      Uri.parse("https://saavn.dev/api/search/songs?query=$query&limit=5"));
  var result = jsonDecode(response.body);
  return SearchSong.fromJson(result);
}
