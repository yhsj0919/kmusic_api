import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/play_list/play_list_controller.dart';
import 'package:kmusic_api_example/player/player_page.dart';
import 'package:kmusic_api_example/widget/app_appbar.dart';
import 'package:kmusic_api_example/widget/app_image.dart';
import 'package:kmusic_api_example/widget/header_delegate.dart';

class PlayListDetailPage extends StatelessWidget {
  PlayListDetailPage({Key? key}) : super(key: key);
  final PlayListController _controller = Get.put(PlayListController());

  final Map<String, dynamic> playList = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return PlayerPage(
        imageUrl: RxString(playList["image"] ?? ""),
        body: Obx(
          () => CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                title: Text(
                  "${playList["playlistName"]}",
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                ),
                elevation: 0,
                expandedHeight: 180,
                backgroundColor: Colors.transparent,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  stretchModes: [StretchMode.zoomBackground],
                  background: Container(),
                ),
              ),

              // SliverPersistentHeader(
              //   delegate: HeaderDelegate(
              //     minHeight: 140,
              //     maxHeight: 140,
              //     child: Container(
              //       padding: EdgeInsets.symmetric(horizontal: 16),
              //       alignment: Alignment.centerLeft,
              //       child: Row(
              //         children: [
              //           Hero(
              //             tag: playList["image"] ?? "",
              //             child: AppImage(
              //               url: playList["image"] ?? "",
              //               radius: 10,
              //               width: 100,
              //               height: 100,
              //               animationDuration: 0,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              SliverPersistentHeader(
                // 可以吸顶的TabBar
                pinned: true,
                delegate: HeaderDelegate(
                  minHeight: 60,
                  maxHeight: 60,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      border: Border.all(color: Colors.black12, width: 1.0),
                    ),
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
                    return Container(
                      color: Colors.white,
                      child: ListTile(
                        onTap: () {
                          Get.printError(info: json.encode(_controller.songs[index]));
                          _controller.play(_controller.songs[index]);
                        },
                        leading: AppImage(
                          width: 50,
                          height: 50,
                          radius: 10,
                          url: "http://d.musicapp.migu.cn" + _controller.songs[index]['img1'],
                        ),
                        title: Text(
                          _controller.songs[index]['songName'],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        subtitle: Text(
                          (_controller.songs[index]['singerList'] as List).map((e) => e["name"]).join(","),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12),
                          maxLines: 1,
                        ),
                      ),
                    );
                  },
                  childCount: _controller.songs.length,
                ),
              ),
            ],
          ).paddingOnly(bottom: 70),
        ));
  }
}
