import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySnackBar {
  static void show({required String message, String title = '提示'}) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        backgroundColor: Get.context == null
            ? Colors.black
            : Theme.of(Get.context!).scaffoldBackgroundColor,
        colorText: Get.context == null
            ? Colors.white
            : Theme.of(Get.context!).primaryColor);
  }
}
