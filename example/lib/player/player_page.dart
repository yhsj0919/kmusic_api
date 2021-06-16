import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/player/player_controller.dart';
import 'package:kmusic_api_example/widget/blur_widget.dart';
import 'package:kmusic_api_example/widget/weslide/we_slide.dart';

class PlayerPage extends StatelessWidget {
  Widget child;

  PlayerPage({@required this.child});

  final player = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
    final double _panelMaxSize = MediaQuery.of(context).size.height / 5 * 3;
    return Scaffold(
      body: WeSlide(
        backgroundColor: Colors.white,
        panelMinSize: 56,
        panelMaxSize: _panelMaxSize,
        body: child,
        panel: BlurWidget(
          blur: 5,
          // color: Colors.white,
          child: Center(child: Text("这里空空如也😉")),
        ),
        panelHeader: playerBar(),
        bodyBorderRadiusBegin: 0,
        bodyBorderRadiusEnd: 40,
        panelBorderRadiusBegin: 0,
        panelBorderRadiusEnd: 28,
        blur: true,
        transformScale: true,
        overlay: false,
        transformScaleBegin: 1,
        transformScaleEnd: 0.98,
        hidePanelHeader: false,
        blurColor: Colors.black,
      ),
    );
  }

  Widget playerBar() {
    return Obx(
      () => Container(
          alignment: Alignment.center,
          height: 56,
          child: Container(
            width: Get.width - 20,
            child: Row(
              children: [
                head(),
                title(),
                play(),
                playlist(),
              ],
            ),
          )),
    );
  }

  ///头像
  Widget head() {
    return Hero(
        tag: "player_head",
        child: Container(
          width: 56,
          height: 56,
          child: ClipOval(
              child: CachedNetworkImage(
            imageUrl: player.songInfo.value.image?.path ?? "",
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Container(
              color: Colors.black12,
            ),
          )),
        ));
  }

  Widget title() {
    return Expanded(
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        controller: PageController(
          initialPage: 0,
          viewportFraction: 1,
          keepPage: true,
        ),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            child: Text(player.songInfo.value.title == null ? "暂无歌曲" : "${player.songInfo.value.title} - ${player.songInfo.value.artist}"),
          );
        },
      ),
    );
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

  Widget playlist() {
    return InkWell(
      customBorder: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      onTap: () {},
      child: Container(
        width: 45,
        height: 45,
        child: Hero(tag: "player_playlist", child: Icon(Icons.format_list_bulleted, size: 25)),
      ),
    ).marginSymmetric(horizontal: 4);
  }
}
