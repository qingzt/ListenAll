import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';

class MyToast {
  static void show({required String message, String title = '提示'}) {
    showToastWidget(
      Toast(title: title, message: message),
      context: Get.overlayContext!,
      position: StyledToastPosition.bottom,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      duration: const Duration(seconds: 2),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
    );
  }
}

class Toast extends StatelessWidget {
  const Toast({super.key, required this.title, required this.message});
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 5),
              blurRadius: 10,
            ),
          ],
        ),
        child: Center(
          child: ListTile(
            title: Text(title),
            subtitle: Text(message),
          ),
        ));
  }
}
