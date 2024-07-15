// To parse this JSON data, do
//
//     final searchSong = searchSongFromJson(jsonString);

import 'dart:convert';

import 'package:rhythmix/models/song.dart';

SearchSong searchSongFromJson(String str) => SearchSong.fromJson(json.decode(str));

String searchSongToJson(SearchSong data) => json.encode(data.toJson());

class SearchSong {
    bool success;
    Data data;

    SearchSong({
        required this.success,
        required this.data,
    });

    factory SearchSong.fromJson(Map<String, dynamic> json) => SearchSong(
        success: json["success"],
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
    List<Song> results;

    Data({
        required this.total,
        required this.start,
        required this.results,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        total: json["total"],
        start: json["start"],
        results: List<Song>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "start": start,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}
