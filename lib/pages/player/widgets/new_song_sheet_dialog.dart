import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class NewSongSheetDialog extends StatelessWidget {
  NewSongSheetDialog({super.key, required this.searchIndex});
  final int searchIndex;
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('添加到播放列表'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: 90,
        child: Center(
          child: Form(
            key: _formKey,
            child: TextFormField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: '请输入播放列表名称',
                border: OutlineInputBorder(),
                labelText: '播放列表名称',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '播放列表名称不能为空';
                }
                return null;
              },
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              Get.find<PlayerController>().newSongSheet(controller.text);
              Get.back();
              Get.back();
            }
          },
          child: const Text('确定'),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('取消'),
        ),
      ],
    );
  }
}
