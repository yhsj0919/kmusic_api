
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/migu/migu_repository.dart';
import 'package:kmusic_api_example/utils/utils.dart';
import 'package:kmusic_api_example/widget/app_image.dart';
import 'package:kmusic_api_example/widget/page_list_view.dart';

class TabSingerPage extends StatelessWidget {
  TabSingerPage({Key? key}) : super(key: key);
  final TabSingerController _controller = Get.put(TabSingerController());

  @override
  Widget build(BuildContext context) {
    return _controller.obx((datas) {
      return PageListView(
        padding: EdgeInsets.only(bottom: 70),
        totalPage: _controller.totalPage.value,
        thisPage: _controller.thisPage.value,
        itemCount: datas?.length ?? 0,
        itemBuilder: (context, index) {
          return ListTile(
            leading: AppImage(
              url: (datas[index]["singerPicUrl"] as List).last["img"],
              width: 50,
              height: 50,
              radius: 10,
            ),
            title: Text(
              datas[index]["name"],
              maxLines: 1,
              style: Theme.of(context).textTheme.subtitle1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Row(
              children: [
                Text(
                  "单曲: ${datas[index]["songCount"]}",
                  maxLines: 1,
                  style: Theme.of(context).textTheme.caption,
                  overflow: TextOverflow.ellipsis,
                ),
                Container(width: 8),
                Text(
                  "专辑: ${datas[index]["albumCount"]}",
                  maxLines: 1,
                  style: Theme.of(context).textTheme.caption,
                  overflow: TextOverflow.ellipsis,
                ),
                Container(width: 8),
                Text(
                  "视频: ${datas[index]["mvCount"]}",
                  maxLines: 1,
                  style: Theme.of(context).textTheme.caption,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
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

class TabSingerController extends GetxController with StateMixin<dynamic> {
  final migu = MiGuRepository();
  String _keyword = "";

  List datas = [];
  RxInt totalPage = RxInt(0);
  RxInt thisPage = RxInt(0);

  //搜索
  Future<void> search({String keyword: "", int type = 5, int page = 1, int size = 20}) async {
    if (keyword.isNotEmpty) {
      _keyword = keyword;
    }
    if (page == 1) {
      change([], status: RxStatus.loading());
    }
    if (_keyword.isNotEmpty) {
      return migu.search(_keyword, type: type, page: page, size: size).then((value) {
        thisPage.value++;
        if (page == 1) {
          datas.clear();
          thisPage.value = 1;
        }
        datas.addAll((value?["singerResultData"]?["result"] ?? []) as List);
        totalPage.value = getPage(int.tryParse(value?["singerResultData"]?["totalCount"]) ?? 0, size);
        change(datas, status: RxStatus.success());
      });
    } else {
      return Future.value();
    }
  }
}
