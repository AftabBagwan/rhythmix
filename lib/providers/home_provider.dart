import 'package:flutter/material.dart';
import 'package:rhythmix/models/song.dart';
import 'package:rhythmix/services/firestore_remote_data_source.dart';
import 'package:rhythmix/services/base_remote_data_source.dart';
import 'package:rhythmix/utils/constants.dart';

class HomeProvider extends ChangeNotifier {
  bool _isLoading = true;
  List<List<Song>> _topAlbumSongs = [];
  List<Song> _trendingSongs = [];
  Map<String, dynamic> _topArtists = {};

  bool get isLoading => _isLoading;
  List<List<Song>> get topAlbumSongs => _topAlbumSongs;
  List<Song> get trendingSongs => _trendingSongs;
  Map<String, dynamic> get topArtists => _topArtists;

  HomeProvider() {
    _initialize();
  }

  Future<void> _initialize() async {
    await Future.wait([
      loadTopAlbumSongs(),
      loadTrendingSongs(),
      loadTopArtists(),
    ]);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadTopAlbumSongs() async {
    List<List<Song>> listOfAlbum = [];
    List topAlbums = await fetchTopAlbums();
    for (int i = 0; i < topAlbums.length; i++) {
      var album = await searchAlbum(topAlbums[i]);
      listOfAlbum.add(album.data.songs);
    }
    _topAlbumSongs = listOfAlbum;
    notifyListeners();
  }

  Future<void> loadTrendingSongs() async {
    List<Song> listOfTrending = [];
    for (int i = 0; i < trendingSongsList.length; i++) {
      var songs = await searchSong(trendingSongsList[i]);
      listOfTrending.add(songs.data.songs[0]);
    }
    _trendingSongs = listOfTrending;
    notifyListeners();
  }

  Future<void> loadTopArtists() async {
    Map<String, dynamic> artists = await fetchArtists();
    _topArtists = artists;
    notifyListeners();
  }
}
