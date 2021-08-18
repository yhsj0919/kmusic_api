import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/entity/play_list_entity.dart';
import 'package:kmusic_api_example/migu/migu_repository.dart';
import 'package:kmusic_api_example/route/routes.dart';
import 'package:kmusic_api_example/utils/utils.dart';
import 'package:kmusic_api_example/widget/app_image.dart';
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
          final ts = datas?[index].tags;

          return InkWell(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Hero(
                      tag: datas?[index].img ?? "",
                      child: AppImage(
                        url: datas?[index].img ?? "",
                        width: 80,
                        animationDuration: 0,
                        height: 80,
                        radius: 10,
                      )),
                  Container(width: 8),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${datas?[index].name}",
                        maxLines: 2,
                        style: Theme.of(context).textTheme.subtitle1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Container(height: 4),
                      Row(
                        children: [
                          Text(
                            "${datas?[index].musicNum}首",
                            maxLines: 1,
                            style: Theme.of(context).textTheme.caption,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(width: 8),
                          Text(
                            "播放${datas?[index].playNum}次",
                            maxLines: 1,
                            style: Theme.of(context).textTheme.caption,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(width: 8),
                          Text(
                            "${datas?[index].userName}",
                            maxLines: 1,
                            style: Theme.of(context).textTheme.caption,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      Text(
                        "${ts?.isEmpty == true ? "" : '标签: ' + (ts?.join(",") ?? "")}",
                        maxLines: 1,
                        style: Theme.of(context).textTheme.caption,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )),
                ],
              ),
            ),
            onTap: () {
              Get.toNamed(Routes.PLAY_LIST_DETAIL, arguments: datas?[index]);
            },
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

class TabPlayListController extends GetxController with StateMixin<List<PlayListEntity>> {
  final migu = MiGuRepository();
  String _keyword = "";

  List<PlayListEntity> datas = [];
  RxInt totalPage = RxInt(0);
  RxInt thisPage = RxInt(0);

  //搜索
  Future<void> search({String keyword: "", int type = 3, int page = 1, int size = 20}) async {
    if (keyword.isNotEmpty) {
      _keyword = keyword;
    }
    if (page == 1) {
      change(<PlayListEntity>[], status: RxStatus.loading());
    }
    if (_keyword.isNotEmpty) {
      return migu.search(_keyword, type: type, page: page, size: size).then((value) {
        thisPage.value++;
        if (page == 1) {
          datas.clear();
          thisPage.value = 1;
        }

        totalPage.value = getPage(int.tryParse(value?["songListResultData"]?["totalCount"]) ?? 0, size);

        var list = value['songListResultData']['result'] as List;

        datas.addAll(list.map((e) {
          return PlayListEntity(
            id: e["id"],
            name: e["name"],
            img: e["musicListPicUrl"],
            intro: e["intro"],
            keepNum: e["keepNum"],
            musicNum: e["musicNum"],
            type: e["resourceType"],
            playNum: e["playNum"],
            tags: (e["ts"] as List).map((e) => e.toString()).toList(),
            userId: e["userId"],
            userName: e["userName"],
          );
        }).toList());

        change(datas, status: RxStatus.success());
      });
    } else {
      return Future.value();
    }
  }
}
