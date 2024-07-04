import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class SearchPageSearchBar extends StatelessWidget {
  SearchPageSearchBar({super.key, required this.keywords}) {
    controller.text = keywords;
  }
  final String keywords;
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: TextField(
        controller: controller,
        onSubmitted: (value) async {
          Get.find<NetworkSearchController>().search(controller.text);
        },
        decoration: InputDecoration(
          hintText: '请输入搜索内容',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          suffixIcon: TextButton(
            onPressed: () {
              Get.find<NetworkSearchController>().search(controller.text);
            },
            child: const Text('搜索'),
          ),
        ),
      ),
    );
  }
}
