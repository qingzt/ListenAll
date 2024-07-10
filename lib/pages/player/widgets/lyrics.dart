import 'package:flutter/material.dart';
import 'package:flutter_lyric/lyrics_reader.dart';
import 'package:get/get.dart';
import 'package:listenall/pages/player/index.dart';

class Lyrics extends StatelessWidget {
  const Lyrics({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlayerController>(
      id: 'lyrics',
      builder: (_) {
        final lyricsModel = LyricsModelBuilder.create()
            .bindLyricToMain(_.currentMusicInfo?.extendInfo?.lyrics ?? '')
            .getModel();
        return SizedBox(
            child: LyricsReader(
          model: lyricsModel,
          position: _.playedDuration.inMilliseconds,
          lyricUi: MyLyricsUI(),
          selectLineBuilder: (progress, confirm) {
            return Row(
              children: [
                IconButton(
                    onPressed: () {
                      _.audioService.seekTo(Duration(milliseconds: progress));
                    },
                    icon: Icon(Icons.play_arrow,
                        color: Theme.of(context).primaryColor)),
                Expanded(
                  child: Container(
                    decoration:
                        BoxDecoration(color: Theme.of(context).primaryColor),
                    height: 1,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    Duration(milliseconds: progress)
                        .toString()
                        .split('.')
                        .first
                        .split(':')
                        .sublist(1)
                        .join(':'),
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                )
              ],
            );
          },
        ));
      },
    );
  }
}

class MyLyricsUI extends UINetease {
  @override
  TextStyle getPlayingExtTextStyle() => TextStyle(
      color: Theme.of(Get.context!).hintColor, fontSize: defaultExtSize);
  @override
  TextStyle getOtherExtTextStyle() => TextStyle(
        color: Theme.of(Get.context!).hoverColor,
        fontSize: defaultExtSize,
      );
  @override
  TextStyle getOtherMainTextStyle() => TextStyle(
      color: Theme.of(Get.context!).highlightColor, fontSize: otherMainSize);
  @override
  TextStyle getPlayingMainTextStyle() => TextStyle(
        color: Theme.of(Get.context!).primaryColor,
        fontSize: defaultSize,
      );
}
