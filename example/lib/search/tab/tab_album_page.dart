import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/migu/migu_repository.dart';

class TabAlbumPage extends StatelessWidget {
  TabAlbumPage({Key? key}) : super(key: key);
  final TabAlbumController _controller = Get.put(TabAlbumController());

  @override
  Widget build(BuildContext context) {
    return _controller.obx((state) {
      final datas = (state?["albumResultData"]?["result"] ?? []) as List;

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
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Container(
                          color: Colors.black12,
                          width: 55,
                          height: 50,
                          child: CachedNetworkImage(
                            imageUrl: (datas[index]["imgItems"] as List).last["img"],
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
                  })
            ],
          ));
    });
  }
}

class TabAlbumController extends GetxController with StateMixin<dynamic> {
  final migu = MiGuRepository();

  //搜索
  void search(String keyword, {int type = 1}) {
    change([], status: RxStatus.loading());
    if (keyword.isNotEmpty) {
      migu.search(keyword, type: type).then((value) {
        printInfo(info: json.encode(value));
        change(value, status: RxStatus.success());
      });
    } else {}
  }
}
