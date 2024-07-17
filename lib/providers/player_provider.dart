import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:rhythmix/models/search_song.dart';
import 'package:rhythmix/services/remote.dart';
import 'package:rxdart/rxdart.dart';

class PlayerProvider extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  late SearchSong _currentSong;
  bool _isLoading = true;
  bool _hasSelectedSong = false;

  AudioPlayer get player => _player;
  SearchSong get currentSong => _currentSong;
  bool get isLoading => _isLoading;

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
      await loadSong("alone");
    }
  }

  Future<void> loadSong(String songName) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 100));

    try {
      _currentSong = await searchSong(songName);
      await _player.setAudioSource(
        AudioSource.uri(
            Uri.parse(_currentSong.data.results[0].downloadUrl.last.url)),
      );
      _isLoading = false;
      notifyListeners();
    } on PlayerException catch (e) {
      debugPrint("Error loading audio source: $e");
      _isLoading = false;
      notifyListeners();
    }
  }

  void songSelected() {
    _hasSelectedSong = true;
    if (_isLoading) player.play();
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
