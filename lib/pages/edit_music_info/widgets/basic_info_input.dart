import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listenall/pages/edit_music_info/index.dart';

class BasicInfoInput extends StatelessWidget {
  const BasicInfoInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditMusicInfoController>(builder: (_) {
      return Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: max(250, MediaQuery.of(context).size.width * 0.8),
                child: TextField(
                  controller: _.titleController,
                  decoration: InputDecoration(
                    labelText: '标题',
                    hintText: '请输入标题',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: max(250, MediaQuery.of(context).size.width * 0.8),
                child: TextField(
                  controller: _.artistController,
                  decoration: InputDecoration(
                    labelText: '艺术家',
                    hintText: '请输入艺术家',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: max(250, MediaQuery.of(context).size.width * 0.8),
                child: TextField(
                  controller: _.albumController,
                  decoration: InputDecoration(
                    labelText: '专辑',
                    hintText: '请输入专辑',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
