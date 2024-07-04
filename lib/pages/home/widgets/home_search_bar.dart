import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/routers/index.dart';
import '../controller.dart';

class HomeSearchBar extends StatelessWidget {
  HomeSearchBar({super.key});
  final TextEditingController _controller = TextEditingController();

  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: TextField(
        focusNode: focusNode,
        onTapOutside: (context) {
          focusNode.unfocus();
        },
        controller: _controller,
        onSubmitted: (value) async {
          await Get.toNamed(RouteNames.networkSearch,
              parameters: {'query': _controller.text});
          Get.find<HomeController>().flush();
        },
        decoration: InputDecoration(
          hintText: '请输入搜索内容',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          suffixIcon: TextButton(
            onPressed: () async {
              await Get.toNamed(RouteNames.networkSearch,
                  parameters: {'query': _controller.text});
              Get.find<HomeController>().flush();
            },
            child: const Text('搜索'),
          ),
        ),
      ),
    );
  }
}
