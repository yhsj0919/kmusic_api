import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/migu/migu_repository.dart';

class TabPlayListPage extends StatelessWidget {
  TabPlayListPage({Key? key}) : super(key: key);
  final TabPlayListController _controller = Get.put(TabPlayListController());

  @override
  Widget build(BuildContext context) {
    return _controller.obx((state) {
      final datas = (state?["songListResultData"]?["result"] ?? []) as List;

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
                    final ts = datas[index]["ts"] as List;

                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: Container(
                                color: Colors.black12,
                                width: 80,
                                height: 80,
                                child: CachedNetworkImage(
                                  imageUrl: datas[index]["musicListPicUrl"],
                                  fit: BoxFit.cover,
                                  errorWidget: (context, str, value) {
                                    return Container(color: Colors.black12);
                                  },
                                ),
                              )),
                          Container(width: 8),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                datas[index]["name"],
                                maxLines: 2,
                                style: Theme.of(context).textTheme.subtitle2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Container(height: 4),
                              Row(
                                children: [
                                  Text(
                                    "${datas[index]["musicNum"]}首",
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.caption,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Container(width: 8),
                                  Text(
                                    "播放${datas[index]["playNum"]}次",
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.caption,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Container(width: 8),
                                  Text(
                                    "${datas[index]["userName"]}",
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.caption,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Text(
                                "${ts.isEmpty ? "" : '标签: ' + ts.join(",")}",
                                maxLines: 1,
                                style: Theme.of(context).textTheme.caption,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          )),
                        ],
                      ),
                    );
                  })
            ],
          ));
    });
  }
}

class TabPlayListController extends GetxController with StateMixin<dynamic> {
  final migu = MiGuRepository();

  //搜索
  void search(String keyword, {int type = 3}) {
    change([], status: RxStatus.loading());
    if (keyword.isNotEmpty) {
      migu.search(keyword, type: type).then((value) {
        printInfo(info: json.encode(value));
        change(value, status: RxStatus.success());
      });
    } else {}
  }
}
