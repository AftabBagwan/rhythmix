// To parse this JSON data, do
//
//     final searchSong = searchSongFromJson(jsonString);


import 'dart:convert';

import 'package:rhythmix/models/song.dart';

SearchResult searchSongFromJson(String str) =>
    SearchResult.fromJson(json.decode(str));

String searchSongToJson(SearchResult data) => json.encode(data.toJson());

class SearchResult {
    bool success;
    Data data;

  SearchResult({
        required this.success,
        required this.data,
    });

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        success: json["success"] ?? false,
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
    };
}

class Data {
    int total;
    int start;
    List<Song> songs;

    Data({
        required this.total,
        required this.start,
        required this.songs,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        total: json["total"] ?? 0,
        start: json["start"] ?? 0,
        songs: List<Song>.from(json["results"].map((x) => Song.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "start": start,
        "results": List<dynamic>.from(songs.map((x) => x.toJson())),
    };
}

