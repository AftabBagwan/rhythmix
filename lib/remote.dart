import 'dart:convert';

import 'package:rhythmix/models/song.dart';
import 'package:http/http.dart' as http;

Future<Song> getSong() async {
  var response =
      await http.get(Uri.parse("https://saavn.dev/api/search/songs?query=alone"));
  var result = jsonDecode(response.body);
  return Song.fromJson(result);
}
