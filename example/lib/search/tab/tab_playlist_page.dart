
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/migu/migu_repository.dart';
import 'package:kmusic_api_example/utils/utils.dart';
import 'package:kmusic_api_example/widget/page_list_view.dart';

class TabPlayListPage extends StatelessWidget {
  TabPlayListPage({Key? key}) : super(key: key);
  final TabPlayListController _controller = Get.put(TabPlayListController());

  @override
  Widget build(BuildContext context) {
    return _controller.obx((datas) {
      return PageListView(
        padding: EdgeInsets.only(bottom: 70),
        totalPage: _controller.totalPage.value,
        thisPage: _controller.thisPage.value,
        itemCount: datas?.length ?? 0,
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
                      style: Theme.of(context).textTheme.subtitle1,
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

class TabPlayListController extends GetxController with StateMixin<dynamic> {
  final migu = MiGuRepository();
  String _keyword = "";

  List datas = [];
  RxInt totalPage = RxInt(0);
  RxInt thisPage = RxInt(0);

  //搜索
  Future<void> search({String keyword: "", int type = 3, int page = 1, int size = 20}) async {
    if (keyword.isNotEmpty) {
      _keyword = keyword;
    }
    if (page == 1) {
      change([], status: RxStatus.loading());
    }
    if (_keyword.isNotEmpty) {
      return migu.search(_keyword, type: type, page: page, size: size).then((value) {
        // printInfo(info: json.encode(value));
        thisPage.value++;
        if (page == 1) {
          datas.clear();
          thisPage.value = 1;
        }
        datas.addAll((value?["songListResultData"]?["result"] ?? []) as List);
        totalPage.value = getPage(int.tryParse(value?["songListResultData"]?["totalCount"]) ?? 0, size);
        change(datas, status: RxStatus.success());
      });
    } else {
      return Future.value();
    }
  }
}
