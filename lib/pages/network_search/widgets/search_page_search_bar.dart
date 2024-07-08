import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:listenall/common/api/index.dart';

import '../controller.dart';

class SearchPageSearchBar extends StatelessWidget {
  SearchPageSearchBar({super.key, required this.keywords}) {
    controller.text = keywords;
  }
  final String keywords;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NetworkSearchController>(
        id: 'searchBar',
        builder: (_) {
          return Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Center(
                    child: DropdownButton<SearchProvider>(
                      alignment: Alignment.center,
                      borderRadius: BorderRadius.circular(8),
                      isExpanded: true,
                      value: _.allSources[_.currentSourceIndex],
                      iconSize: 24,
                      items: _.allSources
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Center(child: e.getSearchIcon()),
                              ))
                          .toList(),
                      onChanged: (SearchProvider? value) {
                        if (value != null) {
                          _.changeSource(value);
                        }
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    onSubmitted: (value) async {
                      Get.find<NetworkSearchController>()
                          .search(controller.text);
                    },
                    decoration: InputDecoration(
                      hintText: '请输入搜索内容',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: TextButton(
                        onPressed: () {
                          Get.find<NetworkSearchController>()
                              .search(controller.text);
                        },
                        child: const Text('搜索'),
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
