import 'dart:convert';

import 'package:rhythmix/models/search_song.dart';
import 'package:rhythmix/models/song.dart';
import 'package:http/http.dart' as http;

Future<Song> getSong() async {
  var response = await http
      .get(Uri.parse("https://saavn.dev/api/search/songs?query=alone"));
  var result = jsonDecode(response.body);
  return Song.fromJson(result);
}

Future<SearchSong> searchSong(String query) async {
  var response =
      await http.get(Uri.parse("https://saavn.dev/api/search/songs?query=$query"));
  var result = jsonDecode(response.body);
  return SearchSong.fromJson(result);
}
