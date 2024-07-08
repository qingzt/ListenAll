import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

import 'window_buttons.dart';

class ListenAllAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ListenAllAppBar({super.key, this.bottom});
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize =>
      Size.fromHeight(40 + (bottom?.preferredSize.height ?? 0));

  Widget _buildAppBar() {
    if (Platform.isWindows) {
      return AppBar(
          bottom: bottom,
          title: WindowTitleBarBox(
            child: Row(
              children: [
                Expanded(
                    child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 4),
                      child: const Text('Listen All',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    MoveWindow(),
                  ],
                )),
                const WindowButtons()
              ],
            ),
          ));
    }
    return AppBar(
      bottom: bottom,
      title: const Text('Listen All',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildAppBar();
  }
}
