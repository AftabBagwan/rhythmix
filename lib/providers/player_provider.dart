import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:rhythmix/models/search_song.dart';
import 'package:rhythmix/models/song.dart';
import 'package:rhythmix/services/remote.dart';
import 'package:rxdart/rxdart.dart';

class PlayerProvider extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  late Song _currentSong;
  bool _isLoading = true;
  bool _hasSelectedSong = false;
  late List<Song> _songQueue;
  int _index = 0;

  AudioPlayer get player => _player;
  Song get currentSong => _currentSong;
  bool get isLoading => _isLoading;
  bool get hasSelectedSong => _hasSelectedSong;
  List<Song> get songQueue => _songQueue;
  int get index => _index;

  PlayerProvider() {
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());

    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      debugPrint('A stream error occurred: $e');
    });

    if (!_hasSelectedSong) {
      SearchSong defaultSong = await searchSong("alone");
      _songQueue = defaultSong.data.songs;
      await selectSong(defaultSong.data.songs[0]);
    }
  }

  Future<void> selectSong(Song song) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 100));

    try {
      await _player.stop();
      _currentSong = song;
      await _player.setAudioSource(
        AudioSource.uri(Uri.parse(song.downloadUrl.last.url)),
      );
      _isLoading = false;
      notifyListeners();
      if (_hasSelectedSong) {
        _player.play();
      }
    } on PlayerException catch (e) {
      debugPrint("Error loading audio source: $e");
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectSongQueue(List<Song> songs) {
    _songQueue = songs;
  }

  void setIndex(int newIndex) {
    _index = newIndex;
  }

  void playSong() {
    _player.play();
    notifyListeners();
  }

  void pauseSong() {
    _player.pause();
    notifyListeners();
  }

  void songSelected() {
    _hasSelectedSong = true;
  }

  Stream<PositionData> get positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _player.positionStream,
        _player.bufferedPositionStream,
        _player.durationStream,
        (position, bufferedPosition, duration) =>
            PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}
