import 'dart:async';

import 'package:get/get.dart';

import '../../common/models/index.dart';
import '../../common/services/index.dart';

class PlayerController extends GetxController {
  AudioService audioService = Get.find<AudioService>();
  MusicInfo? currentMusicInfo;
  StreamSubscription? playedDurationSubscription;
  var isLike = false;
  var isPlaying = false;
  var isBuffering = false;
  var playedDuration = Duration.zero;
  var totalDuration = Duration.zero;
  var bufferedDuration = Duration.zero;
  int playMode = 0;
  int currentPlayListItemIndex = 0;
  List<PlayableItem> playList = [];
  List<SongSheet> songSheets = [];
  PlayerController();

  _initData() {
    update(["player"]);
  }

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    audioService.isPlayingStream.listen((event) {
      isPlaying = event;
      update(['actionButton', 'playBar']);
    });
    audioService.isBufferingStream.listen((event) {
      isBuffering = event;
      update(['actionButton', 'playBar']);
    });
    playedDurationSubscription =
        audioService.playedDurationStream.listen((event) {
      playedDuration = event;
      update(['progressIndicator', 'lyrics']);
    });
    audioService.totalDurationStream.listen((event) {
      totalDuration = event;
      update(['progressIndicator', 'lyrics']);
    });
    audioService.bufferedDurationStream.listen((event) {
      bufferedDuration = event;
      update(['progressIndicator']);
    });
    audioService.currentMusicInfoStream.listen((event) {
      currentMusicInfo = event;
      update(['musicInfo', 'playBar', 'lyrics']);
    });
    audioService.playlistStream.listen((event) {
      playList = event;
      update(['playlist']);
    });
    audioService.playModeStream.listen((event) {
      playMode = event;
      update(['actionButton']);
    });
    audioService.isLikeStream.listen((event) {
      isLike = event;
      update(['musicInfo']);
    });
    audioService.playlistItemIndexStream.listen((event) {
      currentPlayListItemIndex = event;
      update(['playlist']);
    });
    playList = AudioService.to.playlist;
    currentMusicInfo = AudioService.to.currentMusicInfo;
    isLike = AudioService.to.isLike;
    currentPlayListItemIndex = audioService.targetIndex;
    _initData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  void seekTo(Duration newDuration) {
    playedDurationSubscription?.cancel();
    playedDuration = newDuration;
    update(['progressIndicator']);
    audioService.seekTo(newDuration).then((value) {
      playedDurationSubscription =
          audioService.playedDurationStream.listen((event) {
        playedDuration = event;
        update(['progressIndicator', 'lyrics']);
      });
    });
  }

  void playOrPause() async {
    audioService.playOrPause();
  }

  void next() {
    audioService.next();
  }

  void previous() {
    audioService.previous();
  }

  void changeMode() {
    audioService.changeMode();
  }

  void selectToPlay(int index) {
    audioService.selectToPlay(index);
  }

  void removePlaylistItem(int index) async {
    audioService.removePlaylistItem(index);
  }

  void likeOrUnlike() {
    audioService.likeOrUnlike();
  }

  Future<void> flushSongSheet() async {
    songSheets = await DatabaseService.to.getSongSheets();
    update(["songSheet"]);
  }

  Future<void> add2SongSheet(String songSheetName) async {
    final BasicMusicInfo musicBasicInfo = currentMusicInfo!.basicInfo;
    await DatabaseService.to.add2SongSheet(musicBasicInfo, songSheetName);
  }

  Future<void> newSongSheet(String name) async {
    final BasicMusicInfo musicBasicInfo = currentMusicInfo!.basicInfo;
    await DatabaseService.to.newSongSheet(musicBasicInfo, name);
  }
}
