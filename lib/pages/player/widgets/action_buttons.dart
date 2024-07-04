import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../controller.dart';
import 'play_list_sheet.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});
  Icon playModeIcon(int playMode) {
    switch (playMode) {
      case 0:
        return const Icon(Icons.repeat);
      case 1:
        return const Icon(Icons.shuffle);
      case 2:
        return const Icon(Icons.repeat_one);
      default:
        return const Icon(Icons.repeat);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlayerController>(
      id: "actionButton",
      builder: (_) {
        return SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                iconSize: 25,
                icon: playModeIcon(_.playMode),
                onPressed: () {
                  _.changeMode();
                },
              ),
              IconButton(
                iconSize: 25,
                icon: const Icon(Icons.skip_previous),
                onPressed: () {
                  _.previous();
                },
              ),
              IconButton(
                iconSize: 35,
                icon: _.isBuffering
                    ? const CircularProgressIndicator()
                    : (_.isPlaying
                        ? const Icon(Icons.pause)
                        : const Icon(Icons.play_arrow)),
                onPressed: () {
                  _.playOrPause();
                },
              ),
              IconButton(
                iconSize: 25,
                icon: const Icon(Icons.skip_next),
                onPressed: () {
                  _.next();
                },
              ),
              IconButton(
                iconSize: 25,
                icon: const Icon(Icons.queue_music),
                onPressed: () {
                  showMaterialModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => PlayListSheet(),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
