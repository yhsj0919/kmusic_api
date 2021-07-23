import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/migu/migu_repository.dart';
import 'package:kmusic_api_example/widget/page_list_view.dart';

class TabVideoPage extends StatelessWidget {
  TabVideoPage({Key? key}) : super(key: key);
  final TabVideoController _controller = Get.put(TabVideoController());

  @override
  Widget build(BuildContext context) {
    return _controller.obx((datas) {
      return PageListView(
        padding: EdgeInsets.only(bottom: 70),
        totalCount: _controller.totalCount.value,
        pageSize: 20,
        itemCount: datas?.length ?? 0,
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
                          imageUrl: ((datas[index]?["mvList"] as List?)?.first?["mvPicUrl"] as List?)?.last?["img"] ?? "",
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
                      style: Theme.of(context).textTheme.subtitle1,
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
        },
        onRefresh: (int index) {
          return _controller.search();
        },
        onLoadMore: (index) {
          printInfo(info: "加载更多$index");
          return _controller.search(page: index);
        },
      );
    });
  }
}

class TabVideoController extends GetxController with StateMixin<dynamic> {
  final migu = MiGuRepository();
  String _keyword = "";

  List datas = [];
  RxInt totalCount = RxInt(0);

  //搜索
  Future<void> search({String keyword: "", int type = 2, int page = 1, int size = 20}) async {
    if (keyword.isNotEmpty) {
      _keyword = keyword;
    }
    if (page == 1) {
      change([], status: RxStatus.loading());
    }
    if (_keyword.isNotEmpty) {
      return migu.search(_keyword, type: type, page: page, size: size).then((value) {
        printInfo(info: json.encode(value));
        if (page == 1) {
          datas.clear();
        }
        datas.addAll((value?["mvSongResultData"]?["result"] ?? []) as List);
        totalCount.value = int.tryParse(value?["mvSongResultData"]?["totalCount"]) ?? 0;
        change(datas, status: RxStatus.success());
      });
    } else {
      return Future.value();
    }
  }
}
