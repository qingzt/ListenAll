import 'package:flutter/material.dart';

class IconButtonWithText extends StatelessWidget {
  const IconButtonWithText(
      {super.key,
      required this.icon,
      required this.text,
      required this.onPressed});
  final IconData icon;
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 90,
        width: 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: onPressed,
              icon: Icon(icon),
              iconSize: 30,
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
