import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/player/player_controller.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PlayerPage extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final RxDouble? opacity;
  final bool withPlayer;
  final RxString? imageUrl;

  PlayerPage({required this.body, this.appBar, this.opacity, this.withPlayer = true, this.imageUrl});

  final player = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
    final double _panelMaxSize = MediaQuery.of(context).size.height / 5 * 3;
    return Material(
        child: Stack(
      children: [
        //添加一个默认背景
        Container(color: Colors.white),
        //图片背景
        imageUrl == null
            ? Container()
            : Obx(
                () => imageUrl?.value == ""
                    ? Container()
                    : AnimatedOpacity(
                        // 使用一个AnimatedOpacity Widget
                        opacity: opacity?.value ?? 0.8,
                        duration: Duration(milliseconds: 400), //过渡时间：1
                        child: CachedNetworkImage(
                          width: Get.width,
                          height: Get.height,
                          imageUrl: imageUrl!.value,
                          fit: BoxFit.fill,
                        ),
                      ),
              ),
        //高斯模糊
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 50,
            sigmaY: 50,
          ),
          child: withPlayer
              ? SlidingUpPanel(
                  color: Colors.transparent,
                  controller: player.panelController,
                  body: Scaffold(backgroundColor: Color(0xccffffff), appBar: appBar, body: body),
                  minHeight: 70,
                  maxHeight: _panelMaxSize,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  panelBuilder: (ScrollController sc) => ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10,
                          sigmaY: 10,
                        ),
                        child: Container(
                          color: Colors.white60,
                          child: playlist(sc),
                        ),
                      )),
                  header: playerBar(),
                  backdropEnabled: true,
                  backdropColor: Color(0x013ffffff),
                )
              : Scaffold(appBar: appBar, body: body),
        ),
      ],
    ));
  }

  Widget playerBar() {
    return Obx(
      () => Container(
        alignment: Alignment.center,
        height: 70,
        padding: EdgeInsets.symmetric(horizontal: 8),
        width: Get.width,
        child: Row(
          children: [
            head(),
            title(),
            play(),
            playlistButton(),
          ],
        ),
      ),
    );
  }

  ///头像
  Widget head() {
    return Hero(
      tag: "player_head",
      child: Container(
        width: 50,
        height: 50,
        child: ClipOval(
          child: player.songInfo.value.image?.path == null || player.songInfo.value.image?.path.isBlank == true
              ? Container(color: Colors.black12)
              : CachedNetworkImage(
                  imageUrl: player.songInfo.value.image?.path ?? "",
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Container(color: Colors.black12),
                ),
        ),
      ),
    );
  }

  ///标题
  Widget title() {
    return Expanded(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.songInfo.value.title == null ? "暂无歌曲" : "${player.songInfo.value.title}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16),
                ),
                Container(height: 4),
                Text(
                  "${player.songInfo.value.artist ?? ""}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: Color(0xff666666)),
                ),
              ],
            )));
  }

  Widget play() {
    return InkWell(
      customBorder: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      onTap: player.isBuffering.value == true
          ? null
          : () {
              player.playOrPause();
            },
      child: Container(
        width: 45,
        height: 45,
        child: Stack(
          alignment: Alignment.center,
          children: [
            player.isBuffering.value == true
                ? Hero(tag: "player_Progress1", child: const CircularProgressIndicator(strokeWidth: 2, backgroundColor: Colors.black12))
                : Hero(
                    tag: "player_Progress2",
                    child: CircularProgressIndicator(value: player.position.value / player.duration.value, strokeWidth: 1, backgroundColor: Colors.black12)),
            Hero(
                tag: "player_play",
                child: Icon(
                  player.playerState == PlayerState.play ? Icons.pause : Icons.play_arrow,
                  size: 25,
                )),
          ],
        ),
      ),
    ).marginSymmetric(horizontal: 4);
  }

  Widget playlistButton() {
    return IconButton(
      onPressed: () {
        if (player.panelController.isPanelOpen) {
          player.panelController.close();
        } else {
          player.panelController.open();
        }
      },
      icon: Container(
        width: 45,
        height: 45,
        child: Hero(tag: "player_playlist", child: Icon(Icons.format_list_bulleted, size: 25)),
      ),
    ).marginSymmetric(horizontal: 4);
  }

  Widget playlist(ScrollController sc) {
    return Obx(() => ListView.builder(
        controller: sc,
        physics: BouncingScrollPhysics(),
        itemCount: player.playList.length,
        itemBuilder: (context, index) {
          return Material(
              color: Colors.transparent,
              child: Ink(
                  child: InkWell(
                splashColor: Colors.black26,
                onTap: () {
                  player.play(player.playList[index]);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Text(
                    player.playList[index]["songName"],
                    style: TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              )));
        })).marginOnly(top: 50);
  }
}
