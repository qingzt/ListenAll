import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySnackBar {
  static void show({required String message, String title = ''}) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        backgroundColor: Theme.of(Get.context!).highlightColor.withOpacity(0.8),
        colorText: Theme.of(Get.context!).primaryColor);
  }
}
