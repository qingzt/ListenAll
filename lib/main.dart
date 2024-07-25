import 'dart:io';
import 'dart:math';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:audio_service/audio_service.dart' as audio_handler;

import 'common/routers/index.dart';
import 'common/services/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  await Get.putAsync(() => DatabaseService().init());
  await Get.putAsync(() => AudioService().init());
  await audio_handler.AudioService.init(
    builder: () => MyAudioHandler(),
    config: const audio_handler.AudioServiceConfig(
      androidNotificationChannelId: 'com.example.listen_all',
      androidNotificationChannelName: 'Listen All',
    ),
  );
  runApp(const MyApp());
  if (Platform.isWindows) {
    doWhenWindowReady(() {
      const initialSize = Size(1000, 600);
      appWindow.minSize = const Size(350, 700);
      appWindow.size = initialSize;
      appWindow.alignment = Alignment.center;
      appWindow.title = 'Listen All';
      appWindow.show();
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Listen All',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: randomColor()),
          useMaterial3: true,
        ),
        getPages: RoutePages.list,
        defaultTransition: Transition.native);
  }

  Color randomColor() {
    return Color((Random().nextDouble() * 0xFFFFFFFF).toInt()).withOpacity(1.0);
  }
}
