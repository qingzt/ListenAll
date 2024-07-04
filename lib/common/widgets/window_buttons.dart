import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonColors = WindowButtonColors(
        iconNormal: Theme.of(context).colorScheme.primary,
        mouseOver: Theme.of(context).colorScheme.secondary,
        mouseDown: Theme.of(context).colorScheme.onPrimary,
        iconMouseOver: Theme.of(context).colorScheme.onPrimary,
        iconMouseDown: Theme.of(context).colorScheme.onPrimary);

    final closeButtonColors = WindowButtonColors(
        mouseOver: const Color(0xFFD32F2F),
        mouseDown: const Color(0xFFB71C1C),
        iconNormal: Theme.of(context).colorScheme.primary,
        iconMouseOver: Colors.white);
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}
