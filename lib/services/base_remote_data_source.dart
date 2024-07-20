import 'dart:convert';

import 'package:rhythmix/models/search_song.dart';
import 'package:http/http.dart' as http;

Future<SearchResult> searchSong(String query) async {
  var response = await http.get(
      Uri.parse("https://saavn.dev/api/search/songs?query=$query&limit=1"));
  var result = jsonDecode(response.body);
  return SearchResult.fromJson(result);
}

Future<SearchResult> searchAlbum(String query) async {
  var response =
      await http.get(
      Uri.parse("https://saavn.dev/api/search/songs?query=$query&limit=5"));
  var result = jsonDecode(response.body);
  return SearchResult.fromJson(result);
}

Future<SearchResult> searchArtist(String query) async {
  var response = await http.get(
      Uri.parse("https://saavn.dev/api/search/songs?query=$query&limit=20"));
  var result = jsonDecode(response.body);
  return SearchResult.fromJson(result);
}

Future<SearchResult> searchGenre(String query) async {
  var response = await http.get(
      Uri.parse("https://saavn.dev/api/search/songs?query=$query&limit=50"));
  var result = jsonDecode(response.body);
  return SearchResult.fromJson(result);
}

Future<SearchResult> globalSearch(String query) async {
  var response = await http.get(
      Uri.parse("https://saavn.dev/api/search/songs?query=$query&limit=10"));
  var result = jsonDecode(response.body);
  return SearchResult.fromJson(result);
}
