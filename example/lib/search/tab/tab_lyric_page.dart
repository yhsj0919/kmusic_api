import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/migu/migu_repository.dart';

class TabLyricPage extends StatelessWidget {
  TabLyricPage({Key? key}) : super(key: key);
  final TabLyricController _controller = Get.put(TabLyricController());

  @override
  Widget build(BuildContext context) {
    return _controller.obx((state) {
      final datas = (state?["lyricResultData"]?["result"] ?? []) as List;

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
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            datas[index]["name"],
                            maxLines: 2,
                            style: Theme.of(context).textTheme.subtitle1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(height: 4),
                          Row(
                            children: [
                              Text(
                                "${datas[index]["singer"]}",
                                maxLines: 1,
                                style: Theme.of(context).textTheme.overline!.copyWith(color: Colors.black54),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                child: Text(
                                  "•",
                                  style: Theme.of(context).textTheme.overline!.copyWith(color: Colors.black54),
                                ),
                              ),
                              Text(
                                "${datas[index]["album"]}",
                                maxLines: 1,
                                style: Theme.of(context).textTheme.overline!.copyWith(color: Colors.black54),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          Container(height: 4),
                          Text(
                            "${datas[index]["multiLyricStr"]}",
                            // maxLines: 1,
                            style: Theme.of(context).textTheme.overline!.copyWith(color: Colors.black87),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  })
            ],
          ));
    });
  }
}

class TabLyricController extends GetxController with StateMixin<dynamic> {
  final migu = MiGuRepository();

  //搜索
  void search(String keyword, {int type = 4}) {
    change([], status: RxStatus.loading());
    if (keyword.isNotEmpty) {
      migu.search(keyword, type: type).then((value) {

        change(value, status: RxStatus.success());
      });
    } else {}
  }
}
