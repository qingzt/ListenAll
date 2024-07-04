import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';

import '../models/index.dart';
import 'database_service.dart';

class AudioService extends GetxService {
  Future<AudioService> init() async {
    super.onInit();
    _player.stream.log.listen((event) {
      // ignore: avoid_print
      print(event);
    });
    _player.stream.error.listen((event) {
      // ignore: avoid_print
      print(event);
    });
    _player.stream.completed.listen((event) {
      if (!event) return;
      if (playMode == 2) {
        _setSource();
        return;
      }
      next();
    });
    await _flushPlayList();
    await _setSource(autoPlay: false);
    currentPlayListItemIndex = _currentPlayListItemIndex;
    return this;
  }

  static AudioService get to => Get.find<AudioService>();

  final Player _player = Player();

  Stream<int> get playlistItemIndexStream =>
      _playlistItemIndexController.stream;

  Stream<bool> get isLikeStream => _isLikeController.stream;

  Stream<int> get playModeStream => _playModeController.stream;

  Stream<bool> get isPlayingStream => _player.stream.playing;

  Stream<bool> get isBufferingStream => _player.stream.buffering;

  Stream<bool> get isCompletedStream => _player.stream.completed;

  Stream<Duration> get playedDurationStream => _player.stream.position;

  Stream<Duration> get totalDurationStream => _player.stream.duration;

  Stream<Duration> get bufferedDurationStream => _player.stream.buffer;

  Stream<MusicInfo?> get currentMusicInfoStream =>
      _currentMusicInfoController.stream;

  Stream<List<PlayableItem>> get playlistStream => _playlistController.stream;

  final StreamController<int> _playlistItemIndexController =
      StreamController<int>.broadcast();

  final StreamController<bool> _isLikeController =
      StreamController<bool>.broadcast();

  final StreamController<int> _playModeController =
      StreamController<int>.broadcast();

  final StreamController<MusicInfo?> _currentMusicInfoController =
      StreamController<MusicInfo?>.broadcast();

  final StreamController<List<PlayableItem>> _playlistController =
      StreamController<List<PlayableItem>>.broadcast();

  List<PlayableItem> get playlist => _playlist;
  MusicInfo? currentMusicInfo;

  bool isLike = false;

  List<PlayableItem> _playlist = [];
  int get _currentPlayListItemIndex =>
      DatabaseService.to.currentPlayListItemIndex;
  int currentPlayListItemIndex = 0;

  set _currentPlayListItemIndex(int value) {
    if (value < 0) {
      DatabaseService.to.currentPlayListItemIndex = 0;
      return;
    }
    if (_currentPlayListItemIndex != value) {
      DatabaseService.to.currentPlayListItemIndex = value;
      _playlistItemIndexController.add(_currentPlayListItemIndex);
      DatabaseService.to.isLike(_playlist[value].basicInfo).then((value) {
        _isLikeController.add(value);
      });
    }
  }

  int playMode = 0;
  // 0: repeat
  // 1: random
  // 2: repeat one

  Future<void> seekTo(Duration newDuration) async {
    await _player.seek(newDuration);
  }

  Future<void> _setSource({bool autoPlay = true}) async {
    if (_playlist.length <= _currentPlayListItemIndex) {
      _currentPlayListItemIndex = 0;
      return;
    }
    final meida =
        await _playlist[_currentPlayListItemIndex].sources[0].getMedia();
    final musicInfo =
        await _playlist[_currentPlayListItemIndex].infos[0].getMusicInfo();
    if (musicInfo != null) {
      musicInfo.title = _playlist[_currentPlayListItemIndex].basicInfo.title;
      musicInfo.artist = _playlist[_currentPlayListItemIndex].basicInfo.artist;
      musicInfo.album = _playlist[_currentPlayListItemIndex].basicInfo.album;
    }
    _currentMusicInfoController.add(musicInfo);
    currentMusicInfo = musicInfo;

    if (meida == null) return;
    await _player.open(meida, play: autoPlay);

    isLike = await DatabaseService.to
        .isLike(_playlist[_currentPlayListItemIndex].basicInfo);
  }

  Future<void> playOrPause() async {
    await _player.playOrPause();
  }

  Future<void> play() async {
    await _player.play();
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> next() async {
    if (_playlist.isEmpty) return;
    switch (playMode) {
      case 0:
        _currentPlayListItemIndex =
            (_currentPlayListItemIndex + 1) % _playlist.length;
        break;
      case 1:
        _currentPlayListItemIndex = Random().nextInt(_playlist.length);
        break;
      case 2:
        _currentPlayListItemIndex =
            (_currentPlayListItemIndex + 1) % _playlist.length;
      default:
    }
    await _setSource();
  }

  Future<void> previous() async {
    if (_playlist.isEmpty) return;
    switch (playMode) {
      case 0:
        _currentPlayListItemIndex =
            (_currentPlayListItemIndex - 1 + _playlist.length) %
                _playlist.length;
        break;
      case 1:
        _currentPlayListItemIndex = Random().nextInt(_playlist.length);
        break;
      case 2:
        _currentPlayListItemIndex =
            (_currentPlayListItemIndex - 1 + _playlist.length) %
                _playlist.length;
        break;
      default:
    }
    await _setSource();
  }

  void changeMode() {
    playMode = (playMode + 1) % 3;
    _playModeController.add(playMode);
  }

  Future<void> selectToPlay(int index) async {
    _currentPlayListItemIndex = index;
    await _setSource();
  }

  void stop() {
    _player.stop();
    _currentMusicInfoController.add(null);
  }

  void removePlaylistItem(int index) async {
    if (index == _currentPlayListItemIndex) {
      await next();
    }
    await DatabaseService.to
        .removeCurrentPlaylistItem(_playlist[index].basicInfo);
    await _flushPlayList();
    if (playlist.isEmpty) {
      stop();
    }
  }

  Future<void> _flushPlayList() async {
    _playlist = [];
    _playlist = await DatabaseService.to.getCurrentPlaylist();
    _playlistController.add(_playlist);
  }

  Future<bool> add2CurrentPlayList(MusicBasicInfo song) async {
    var res = await DatabaseService.to.add2CurrentPlaylist(song);
    if (res) {
      _flushPlayList();
    }
    return res;
  }

  Future<bool> add2CurrentPlayListAndPlay(MusicBasicInfo song) async {
    var res = await DatabaseService.to.add2CurrentPlaylist(song);
    if (res) {
      await _flushPlayList();
      _currentPlayListItemIndex = _playlist.length - 1;
      _setSource();
    } else {
      _currentPlayListItemIndex =
          _playlist.indexWhere((element) => element.basicInfo == song);
      _setSource();
    }
    return res;
  }

  Future<bool> add2CurrentPlayNext(MusicBasicInfo song) async {
    var res = await DatabaseService.to
        .add2CurrentPlaylistByIndex(song, _currentPlayListItemIndex + 1);
    if (res) {
      _flushPlayList();
    }
    return res;
  }

  Future<void> likeOrUnlike() async {
    var song = _playlist[_currentPlayListItemIndex].basicInfo;
    final res = await DatabaseService.to.likeOrUnlike(song);
    _isLikeController.add(res);
    isLike = res;
  }

  Future<void> changePlaylist(List<MusicBasicInfo> songs) async {
    await DatabaseService.to.changeCurrentPlaylist(songs);
    await _flushPlayList();
  }

  @override
  void onClose() {
    _player.dispose();
    super.onClose();
  }
}
