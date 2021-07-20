import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/migu/migu_repository.dart';

class TabVideoPage extends StatelessWidget {
  TabVideoPage({Key? key}) : super(key: key);
  final TabVideoController _controller = Get.put(TabVideoController());

  @override
  Widget build(BuildContext context) {
    return _controller.obx((state) {
      final datas = (state?["mvSongResultData"]?["result"] ?? []) as List;

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
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                child: Container(
                                  color: Colors.black12,
                                  width: 160,
                                  height: 90,
                                  child: CachedNetworkImage(
                                    imageUrl: ((datas[index]["mvList"] as List).first["mvPicUrl"] as List).last["img"],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(2),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.videocam,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "${(datas[index]["mvList"] as List).first["playNum"]}",
                                      style: TextStyle(color: Colors.white, fontSize: 12),
                                    )
                                  ],
                                ),
                              )
                            ],
                            alignment: Alignment.bottomLeft,
                          ),
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
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.music_video, size: 14),
                                  Container(width: 8),
                                  Text(
                                    "${(datas[index]["singers"] as List).map((e) => e["name"]).join(",")}",
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.caption,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              )
                            ],
                          ))
                        ],
                      ),
                    );
                  })
            ],
          ));
    });
  }
}

class TabVideoController extends GetxController with StateMixin<dynamic> {
  final migu = MiGuRepository();

  //搜索
  void search(String keyword, {int type = 2}) {
    change([], status: RxStatus.loading());
    if (keyword.isNotEmpty) {
      migu.search(keyword, type: type).then((value) {
        printInfo(info: json.encode(value));
        change(value, status: RxStatus.success());
      });
    } else {}
  }
}
