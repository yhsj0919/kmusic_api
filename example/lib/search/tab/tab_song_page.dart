import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/migu/migu_repository.dart';

class TabSongPage extends StatelessWidget {
  TabSongPage({Key? key}) : super(key: key);
  final TabSongController _controller = Get.put(TabSongController());

  @override
  Widget build(BuildContext context) {
    return _controller.obx((state) {
      final datas = (state?["songResultData"]?["result"] ?? []) as List;

      return SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 70),
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              ListView.builder(
                  itemCount: datas.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        datas[index]["name"],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        "${(datas[index]["artists"] as List).map((e) => e["name"]).join(",")}",
                        maxLines: 1,
                      ),
                    );
                  })
            ],
          ));
    });
  }
}

class TabSongController extends GetxController with StateMixin<dynamic> {
  final migu = MiGuRepository();

  //搜索
  void search(String keyword, {int type = 0}) {
    change([], status: RxStatus.loading());
    if (keyword.isNotEmpty) {
      migu.search(keyword, type: type).then((value) {
        printInfo(info: json.encode(value));
        change(value, status: RxStatus.success());
      });
    } else {}
  }
}
