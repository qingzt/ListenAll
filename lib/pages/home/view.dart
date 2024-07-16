import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../common/widgets/index.dart';
import '../player/index.dart';
import 'index.dart';
import 'widgets/home_search_bar.dart';
import 'widgets/song_sheet_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<bool> isAndroid13OrHigher() async {
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.version.sdkInt >= 33; // Android 13对应的API级别是33
    }
    return false;
  }

  Future<void> requestPermission() async {
    if (Platform.isWindows) {
      return;
    }
    bool flag = await isAndroid13OrHigher();
    if (flag) {
      // Video permissions.
      if (await Permission.videos.isDenied ||
          await Permission.videos.isPermanentlyDenied) {
        final state = await Permission.videos.request();
        if (!state.isGranted) {
          await SystemNavigator.pop();
        }
      }
      // Audio permissions.
      if (await Permission.audio.isDenied ||
          await Permission.audio.isPermanentlyDenied) {
        final state = await Permission.audio.request();
        if (!state.isGranted) {
          await SystemNavigator.pop();
        }
      }
    } else {
      if (await Permission.storage.isDenied ||
          await Permission.storage.isPermanentlyDenied) {
        final state = await Permission.storage.request();
        if (!state.isGranted) {
          await SystemNavigator.pop();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(PlayerController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const ListenAllAppBar(),
      body: SafeArea(
        child: GetBuilder<HomeController>(
          init: HomeController(),
          initState: (_) {
            requestPermission();
          },
          builder: (_) {
            return LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  return const LargeScreenHome();
                } else {
                  return const DafaultHome();
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class LargeScreenHome extends StatelessWidget {
  const LargeScreenHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      NavigationRail(destinations: const [
        NavigationRailDestination(icon: Icon(Icons.home), label: Text('我的')),
        NavigationRailDestination(icon: Icon(Icons.cloud), label: Text('推荐')),
      ], selectedIndex: 0),
      Expanded(
        child: Column(
          children: [HomeSearchBar(), SongSheetList(), const PlayerBar()],
        ),
      )
    ]);
  }
}

class DafaultHome extends StatelessWidget {
  const DafaultHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeSearchBar(),
        SongSheetList(),
        const PlayerBar(),
        SizedBox(
          height: 60,
          child: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: '我的'),
              BottomNavigationBarItem(icon: Icon(Icons.cloud), label: '推荐'),
            ],
            iconSize: 24,
            selectedFontSize: 12,
            unselectedFontSize: 8,
          ),
        ),
      ],
    );
  }
}
