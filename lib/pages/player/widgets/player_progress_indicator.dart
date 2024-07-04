import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class PlayerProgressIndicator extends StatelessWidget {
  const PlayerProgressIndicator({
    super.key,
  });
  String formatSecondsToMinutesSeconds(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    final formattedSeconds =
        remainingSeconds < 10 ? '0$remainingSeconds' : '$remainingSeconds';
    return '$minutes:$formattedSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlayerController>(
        id: 'progressIndicator',
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ProgressBar(
                  timeLabelLocation: TimeLabelLocation.sides,
                  progress: _.playedDuration,
                  buffered: _.bufferedDuration,
                  total: _.totalDuration,
                  onSeek: (duration) {
                    _.seekTo(duration);
                  },
                )),
          );
        });
  }
}
