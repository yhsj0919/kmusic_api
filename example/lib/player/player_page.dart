import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/player/player_controller.dart';
import 'package:kmusic_api_example/widget/blur_widget.dart';

class PlayerPage extends StatelessWidget {
  Widget child;

  PlayerPage({@required this.child});

  final player = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        child,
        Obx(
          () => BlurWidget(
            width: context.width,
            blur: 4,
            height: 50,
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  child: CachedNetworkImage(
                    imageUrl: player.songInfo.value.image?.path ?? "",
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.black12,
                    ),
                  ),
                ),
                Expanded(
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
                ),
                InkWell(
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
                            ? CircularProgressIndicator(strokeWidth: 2, backgroundColor: Colors.black12)
                            : CircularProgressIndicator(value: player.position.value / player.duration.value, strokeWidth: 1, backgroundColor: Colors.black12),
                        Icon(
                          player.playerState == PlayerState.play ? Icons.pause : Icons.play_arrow,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                ).marginSymmetric(horizontal: 4),
                InkWell(
                  customBorder: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  onTap: () {},
                  child: Container(
                    width: 45,
                    height: 45,
                    child: Icon(Icons.format_list_bulleted, size: 25),
                  ),
                ).marginSymmetric(horizontal: 4),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
