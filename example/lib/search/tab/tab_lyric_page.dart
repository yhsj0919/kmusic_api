import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/migu/migu_repository.dart';
import 'package:kmusic_api_example/utils/utils.dart';
import 'package:kmusic_api_example/widget/page_list_view.dart';

class TabLyricPage extends StatelessWidget {
  TabLyricPage({Key? key}) : super(key: key);
  final TabLyricController _controller = Get.put(TabLyricController());

  @override
  Widget build(BuildContext context) {
    return _controller.obx((datas) {
      return PageListView(
        padding: EdgeInsets.only(bottom: 70),
        totalPage: _controller.totalPage.value,
        thisPage: _controller.thisPage.value,
        itemCount: datas?.length ?? 0,
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
                    Flexible(
                        child: Text(
                      "${datas[index]["singer"]}",
                      maxLines: 1,
                      style: Theme.of(context).textTheme.overline!.copyWith(color: Colors.black54),
                      overflow: TextOverflow.ellipsis,
                    )),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        "•",
                        style: Theme.of(context).textTheme.overline!.copyWith(color: Colors.black54),
                      ),
                    ),
                    Flexible(
                        child: Text(
                      "${datas[index]["album"]}",
                      maxLines: 1,
                      style: Theme.of(context).textTheme.overline!.copyWith(color: Colors.black54),
                      overflow: TextOverflow.ellipsis,
                    )),
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
        },
        onRefresh: (int index) {
          return _controller.search();
        },
        onLoadMore: (index) {
          return _controller.search(page: index);
        },
      );
    });
  }
}

class TabLyricController extends GetxController with StateMixin<dynamic> {
  final migu = MiGuRepository();
  String _keyword = "";

  List datas = [];
  RxInt totalPage = RxInt(0);
  RxInt thisPage = RxInt(0);

  //搜索
  Future<void> search({String keyword: "", int type = 4, int page = 1, int size = 20}) async {
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
        datas.addAll((value?["lyricResultData"]?["result"] ?? []) as List);
        totalPage.value = getPage(int.tryParse(value?["lyricResultData"]?["totalCount"]) ?? 0, size);
        change(datas, status: RxStatus.success());
      });
    } else {
      return Future.value();
    }
  }
}
