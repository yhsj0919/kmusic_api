import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/play_list/play_list_controller.dart';
import 'package:kmusic_api_example/player/player_page.dart';
import 'package:kmusic_api_example/widget/app_appbar.dart';
import 'package:kmusic_api_example/widget/header_delegate.dart';

class PlayListDetailPage extends StatelessWidget {
  PlayListDetailPage({Key? key}) : super(key: key);
  final PlayListController _controller = Get.put(PlayListController());

  final Map<String, dynamic> playList = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return PlayerPage(
        imageUrl: RxString(playList["image"] ?? ""),
        appBar: AppAppBar(
          title: Text(
            "${playList["playlistName"]}",
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
        ),
        body: _controller.obx(
          (datas) => CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverPersistentHeader(
                delegate: HeaderDelegate(
                  minHeight: 140,
                  maxHeight: 140,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl: playList["image"] ?? "",
                          width: 120,
                          height: 120,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                // 可以吸顶的TabBar
                pinned: true,
                delegate: HeaderDelegate(
                  minHeight: 64,
                  maxHeight: 64,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        )),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.play_circle_fill),
                          label: Text("播放全部"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ListTile(
                      onTap: () {
                        Get.printError(info: json.encode(_controller.songs[index]));
                        _controller.play(_controller.songs[index]);
                      },
                      leading: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Container(
                          width: 50,
                          height: 50,
                          child: CachedNetworkImage(
                            imageUrl: "http://d.musicapp.migu.cn" + datas[index]['img1'],
                          ),
                        ),
                      ),
                      title: Text(
                        _controller.songs[index]['songName'],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      subtitle: Text(
                        (datas[index]['singerList'] as List).map((e) => e["name"]).join(","),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12),
                        maxLines: 1,
                      ),
                    );
                  },
                  childCount: datas.length,
                ),
              ),
            ],
          ).paddingOnly(bottom: 70),
        ));
  }
}
