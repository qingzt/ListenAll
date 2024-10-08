import 'dart:async';
import 'dart:math';
import 'package:get/get.dart';
import 'package:listenall/common/services/index.dart';
import 'package:listenall/common/widgets/snack_bar.dart';
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
      MyToast.show(message: event.toString());
    });
    _player.stream.completed.listen((event) {
      if (!event) return;
      if (playMode == 2) {
        _setSource();
        return;
      }
      next();
    });
    _player.stream.playlist.listen((event) {
      targetIndex = _realIndex;
      getInfo();
      currentMusicInfo = MusicInfo(basicInfo: _playlist[_realIndex].basicInfo);
      __currentMusicInfoController.add(currentMusicInfo);
      _playlistItemIndexController.add(_realIndex);
      DatabaseService.to.isLike(_playlist[_realIndex].basicInfo).then((value) {
        _isLikeController.add(value);
        isLike = value;
      });
    });
    await _flushPlayList();

    targetIndex = _realIndex;
    return this;
  }

  @override
  void onReady() {
    super.onReady();
    _setSource(autoPlay: false);
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
      __currentMusicInfoController.stream;

  Stream<List<PlayableItem>> get playlistStream => _playlistController.stream;

  final StreamController<int> _playlistItemIndexController =
      StreamController<int>.broadcast();

  final StreamController<bool> _isLikeController =
      StreamController<bool>.broadcast();

  final StreamController<int> _playModeController =
      StreamController<int>.broadcast();

  final StreamController<MusicInfo?> __currentMusicInfoController =
      StreamController<MusicInfo?>.broadcast();

  final StreamController<List<PlayableItem>> _playlistController =
      StreamController<List<PlayableItem>>.broadcast();

  List<PlayableItem> get playlist => _playlist;
  MusicInfo? currentMusicInfo;

  bool isLike = false;

  List<PlayableItem> _playlist = [];
  int get _realIndex => DatabaseService.to.currentPlayListItemIndex;
  set _realIndex(int index) {
    DatabaseService.to.currentPlayListItemIndex = index;
  }

  int get _sourceIndex => _playlist[_realIndex].currentSourceIndex;
  set _sourceIndex(int index) {
    _playlist[_realIndex].currentSourceIndex = index;
  }

  int get _infoIndex => _playlist[_realIndex].currentInfoIndex;
  set _infoIndex(int index) {
    _playlist[_realIndex].currentInfoIndex = index;
  }

  int targetIndex = 0;
  int get playMode => DatabaseService.to.playMode;
  set playMode(int newMode) {
    DatabaseService.to.playMode = newMode;
  }
  // 0: repeat
  // 1: random
  // 2: repeat one

  Future<void> seekTo(Duration newDuration) async {
    await _player.seek(newDuration);
  }

  Future<void> _setSource({bool autoPlay = true, bool tryNext = true}) async {
    if (_realIndex < 0) {
      _realIndex = 0;
    }
    if (_playlist.length <= _realIndex) {
      _realIndex = 0;
      return;
    }
    Media? media;
    if (_playlist[_realIndex].sources.isEmpty) {
      MyToast.show(message: '当前歌曲无音源');
      tryNextSource(nextSong: tryNext);
      return;
    }
    media = await _playlist[_realIndex]
        .sources[_playlist[_realIndex].currentSourceIndex]
        .getMedia();
    if (media == null) {
      if (tryNext) {
        tryNextSource(nextSong: true);
      }
      return;
    }
    await _player.open(media, play: autoPlay);
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
        _realIndex = (targetIndex + 1) % _playlist.length;
        break;
      case 1:
        _realIndex = Random().nextInt(_playlist.length);
        break;
      case 2:
        _realIndex = (targetIndex + 1) % _playlist.length;
      default:
    }
    await _setSource();
  }

  void tryNextSource({bool nextSong = false}) {
    MyToast.show(message: '无法播放该资源，自动切换下一资源');
    if (_playlist[_realIndex].currentSourceIndex <
        _playlist[_realIndex].sources.length - 1) {
      _sourceIndex++;
      _setSource();
    } else {
      if (nextSong) {
        targetIndex = _realIndex;
        next();
      }
    }
  }

  void getInfo() {
    if (_playlist[_realIndex].infos.isEmpty) return;
    _playlist[_realIndex].infos[_infoIndex].getMusicInfo().then((value) {
      if (value == null) {
        tryNextInfo();
        return;
      }
      currentMusicInfo?.extendInfo = value;
      __currentMusicInfoController.add(currentMusicInfo);
    });
  }

  void tryNextInfo() {
    if (_infoIndex >= _playlist[_realIndex].infos.length - 1) {
      MyToast.show(message: '无法获取歌曲信息');
      return;
    }
    _infoIndex++;
    getInfo();
  }

  Future<void> previous() async {
    if (_playlist.isEmpty) return;
    switch (playMode) {
      case 0:
        _realIndex = (targetIndex - 1 + _playlist.length) % _playlist.length;
        break;
      case 1:
        _realIndex = Random().nextInt(_playlist.length);
        break;
      case 2:
        _realIndex = (targetIndex - 1 + _playlist.length) % _playlist.length;
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
    _realIndex = index;
    await _setSource();
  }

  void stop() {
    _player.stop();
    __currentMusicInfoController.add(null);
  }

  void removePlaylistItem(int index) async {
    if (index == _realIndex) {
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

  Future<bool> add2CurrentPlayList(BasicMusicInfo song) async {
    var res = await DatabaseService.to.add2CurrentPlaylist(song);
    if (res) {
      _flushPlayList();
    }
    return res;
  }

  Future<bool> add2CurrentPlayListAndPlay(BasicMusicInfo song) async {
    var res = await DatabaseService.to.add2CurrentPlaylist(song);
    if (res) {
      await _flushPlayList();
      _realIndex = _playlist.length - 1;
      _setSource(tryNext: false);
    } else {
      _realIndex = _playlist.indexWhere((element) => element.basicInfo == song);
      _setSource(tryNext: false);
    }
    return res;
  }

  Future<bool> add2CurrentPlayNext(BasicMusicInfo song) async {
    var res = await DatabaseService.to
        .add2CurrentPlaylistByIndex(song, _realIndex + 1);
    if (res) {
      _flushPlayList();
    }
    return res;
  }

  Future<void> likeOrUnlike() async {
    var song = _playlist[_realIndex].basicInfo;
    final res = await DatabaseService.to.likeOrUnlike(song);
    _isLikeController.add(res);
    isLike = res;
  }

  Future<void> changePlaylist(List<BasicMusicInfo> songs) async {
    await DatabaseService.to.changeCurrentPlaylist(songs);
    await _flushPlayList();
  }

  @override
  void onClose() {
    _player.dispose();
    super.onClose();
  }
}
