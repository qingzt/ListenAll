import 'package:audio_service/audio_service.dart';
import 'audio_service.dart' as audio_service;

class MyAudioHandler extends BaseAudioHandler
    with
        QueueHandler, // mix in default queue callback implementations
        SeekHandler {
  // mix in default seek callback implementations
  final audio_service.AudioService _player = audio_service.AudioService.to;
  MyAudioHandler() {
    playbackState.add(PlaybackState(
      controls: [
        MediaControl.skipToPrevious,
        MediaControl.play,
        MediaControl.skipToNext,
      ],
      systemActions: const {
        MediaAction.seek,
      },
      androidCompactActionIndices: const [0, 1, 2],
      processingState: AudioProcessingState.loading,
      playing: false,
      speed: 1.0,
    ));
    mediaItem.add(MediaItem(
      id: _player.currentMusicInfo == null
          ? ""
          : _player.currentMusicInfo!.albumArt,
      album: _player.currentMusicInfo == null
          ? ""
          : _player.currentMusicInfo!.album,
      title: _player.currentMusicInfo == null
          ? ""
          : _player.currentMusicInfo!.title,
      artist: _player.currentMusicInfo == null
          ? ""
          : _player.currentMusicInfo!.artist,
      artUri: _player.currentMusicInfo == null
          ? Uri.parse("")
          : Uri.parse(_player.currentMusicInfo!.albumArt),
    ));
    _player.isPlayingStream.listen((isPlaying) {
      if (isPlaying) {
        playbackState.add(playbackState.value.copyWith(controls: [
          MediaControl.skipToPrevious,
          MediaControl.pause,
          MediaControl.skipToNext,
        ], playing: isPlaying, processingState: AudioProcessingState.ready));
      } else {
        playbackState.add(playbackState.value.copyWith(
          controls: [
            MediaControl.skipToPrevious,
            MediaControl.play,
            MediaControl.skipToNext,
          ],
          playing: isPlaying,
          processingState: AudioProcessingState.ready,
        ));
      }
    });
    _player.currentMusicInfoStream.listen((musicInfo) {
      if (musicInfo != null) {
        mediaItem.add(mediaItem.value?.copyWith(
          id: musicInfo.albumArt,
          album: musicInfo.album,
          title: musicInfo.title,
          artist: musicInfo.artist,
          artUri: Uri.parse(musicInfo.albumArt),
        ));
      }
    });
    _player.totalDurationStream.listen((totalDuration) {
      mediaItem.add(mediaItem.value?.copyWith(duration: totalDuration));
    });
    _player.playedDurationStream.listen((playedDuration) {
      playbackState.add(playbackState.value.copyWith(
        updatePosition: playedDuration,
      ));
    });
    _player.bufferedDurationStream.listen((bufferedDuration) {
      playbackState.add(playbackState.value.copyWith(
        bufferedPosition: bufferedDuration,
      ));
    });
  }
  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seekTo(position);

  @override
  Future<void> skipToNext() async {
    await _player.next();
  }

  @override
  Future<void> skipToPrevious() async {
    await _player.previous();
  }
}
