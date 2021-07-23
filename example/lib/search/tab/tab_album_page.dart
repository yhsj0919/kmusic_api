import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/migu/migu_repository.dart';
import 'package:kmusic_api_example/widget/page_list_view.dart';

class TabAlbumPage extends StatelessWidget {
  TabAlbumPage({Key? key}) : super(key: key);
  final TabAlbumController _controller = Get.put(TabAlbumController());

  @override
  Widget build(BuildContext context) {
    return _controller.obx((datas) {
      return PageListView(
        padding: EdgeInsets.only(bottom: 70),
        totalCount: _controller.totalCount.value,
        pageSize: 20,
        itemCount: datas?.length ?? 0,
        itemBuilder: (context, index) {
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                width: 50,
                height: 50,
                child: CachedNetworkImage(
                  imageUrl: (datas[index]["imgItems"] as List).last["img"],
                ),
              ),
            ),
            title: Text(
              "${datas?[index]?["name"]}",
              maxLines: 1,
              style: Theme.of(context).textTheme.subtitle1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Row(
              children: [
                Flexible(
                    child: Text(
                  "${datas[index]["singer"]}",
                  maxLines: 1,
                  style: Theme.of(context).textTheme.caption,
                  overflow: TextOverflow.ellipsis,
                )),
                Container(width: 8),
                Text(
                  "${datas[index]["desc"]}",
                  maxLines: 1,
                  style: Theme.of(context).textTheme.caption,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
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

class TabAlbumController extends GetxController with StateMixin<dynamic> {
  final migu = MiGuRepository();
  String _keyword = "";

  List datas = [];
  RxInt totalCount = RxInt(0);

  //搜索,破分页每次请求返回的条数可能不一样,有可能参数少了,以后再调
  Future<void> search({String keyword: "", int type = 1, int page = 1, int size = 20}) async {
    if (keyword.isNotEmpty) {
      _keyword = keyword;
    }
    if (page == 1) {
      change([], status: RxStatus.loading());
    }
    if (_keyword.isNotEmpty) {
      return migu.search(_keyword, type: type, page: page, size: size).then((value) {
        // printInfo(info: json.encode(value));
        if (page == 1) {
          datas.clear();
        }
        datas.addAll((value?["albumResultData"]?["result"] ?? []) as List);
        totalCount.value = int.tryParse(value?["albumResultData"]?["totalCount"]) ?? 0;

        printInfo(info: "总条数$totalCount");

        change(datas, status: RxStatus.success());
      });
    } else {
      return Future.value();
    }
  }
}
