import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/player/player_controller.dart';
import 'package:kmusic_api_example/widget/blur_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PlayerPage extends StatelessWidget {
  Widget child;

  PlayerPage({@required this.child});

  final player = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
    final double _panelMaxSize = MediaQuery.of(context).size.height / 5 * 3;
    return Scaffold(
      body: SlidingUpPanel(
        color: Colors.transparent,
        controller: player.panelController,
        body: child,
        minHeight: 70,
        maxHeight: _panelMaxSize,
        panelBuilder: (ScrollController sc) => BlurWidget(
          color: Colors.white60,
          radius: 30,
          blur: 10,
          child: playlist(sc),
        ),
        header: playerBar(),
        backdropEnabled: true,
      ),
    );
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
          child: player.songInfo.value.image?.path == null || player.songInfo.value.image?.path?.isBlank == true
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

  Widget title() {
    return Expanded(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      child: Text(player.songInfo.value.title == null ? "暂无歌曲" : "${player.songInfo.value.title} - ${player.songInfo.value.artist}"),
    ));
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
                ? Hero(tag: "player_Progress1", child: CircularProgressIndicator(strokeWidth: 2, backgroundColor: Colors.black12))
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
    return InkWell(
      customBorder: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      onTap: () {
        if (player.panelController.isPanelOpen) {
          player.panelController.close();
        } else {
          player.panelController.open();
        }
      },
      child: Container(
        width: 45,
        height: 45,
        child: Hero(tag: "player_playlist", child: Icon(Icons.format_list_bulleted, size: 25)),
      ),
    ).marginSymmetric(horizontal: 4);
  }

  Widget playlist(ScrollController sc) {
    return ListView.builder(
        controller: sc,
        physics: BouncingScrollPhysics(),
        itemCount: player.playList.length,
        itemBuilder: (context, index) {
          return InkWell(
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
          );
        }).marginOnly(top: 50);
  }
}
