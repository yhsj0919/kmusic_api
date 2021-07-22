import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/migu/migu_repository.dart';

class TabSingerPage extends StatelessWidget {
  TabSingerPage({Key? key}) : super(key: key);
  final TabSingerController _controller = Get.put(TabSingerController());

  @override
  Widget build(BuildContext context) {
    return _controller.obx((state) {
      final datas = (state?["singerResultData"]?["result"] ?? []) as List;

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
                      leading: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child: Container(
                          width: 50,
                          height: 50,
                          child: CachedNetworkImage(
                            imageUrl: (datas[index]["singerPicUrl"] as List).last["img"],
                          ),
                        ),
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
                  })
            ],
          ));
    });
  }
}

class TabSingerController extends GetxController with StateMixin<dynamic> {
  final migu = MiGuRepository();

  //搜索
  void search(String keyword, {int type = 5}) {
    change([], status: RxStatus.loading());
    if (keyword.isNotEmpty) {
      migu.search(keyword, type: type).then((value) {
        change(value, status: RxStatus.success());
      });
    } else {}
  }
}
