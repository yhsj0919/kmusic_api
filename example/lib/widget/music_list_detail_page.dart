import 'dart:ui';

import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart' as ex;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/player/player_page.dart';
import 'package:kmusic_api_example/widget/app_appbar.dart';
import 'package:kmusic_api_example/widget/app_image.dart';
import 'package:kmusic_api_example/widget/header_delegate.dart';

class MusicListDetailPage extends StatelessWidget {
  MusicListDetailPage({
    Key? key,
    required this.img,
    required this.title,
    required this.name,
    this.headWidget: const [],
    required this.playBar,
    required this.body,
  }) : super(key: key);
  final String img;
  final String name;
  final String title;
  final List<Widget> headWidget;
  final Widget playBar;
  final Widget body;

  final RxBool isOpen = RxBool(false);

  @override
  Widget build(BuildContext context) {
    return PlayerPage(
      imageUrl: RxString(img),
      appBar: AppAppBar(
        title: Obx(() => Text(
              "${isOpen.value ? name : title}",
              style: Theme.of(context).appBarTheme.titleTextStyle,
            )),
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: ex.NestedScrollView(
          pinnedHeaderSliverHeightBuilder: () => 60,
          headerSliverBuilder: (BuildContext context, bool? innerBoxIsScrolled) {
            Future.delayed(Duration(milliseconds: 100)).then((value) {
              isOpen.value = innerBoxIsScrolled ?? false;
            });
            return <Widget>[
              _playListHeader(),
              _playBar(),
            ];
          },
          body: _songList(),
        ),
      ),
    );
  }

  Widget _playListHeader() {
    return SliverPersistentHeader(
      delegate: HeaderDelegate(
        minHeight: 130,
        maxHeight: 130,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Hero(
                tag: img,
                child: AppImage(
                  url: img,
                  radius: 10,
                  width: 100,
                  height: 100,
                  animationDuration: 0,
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${name}", style: TextStyle(fontSize: 20), maxLines: 1, overflow: TextOverflow.ellipsis),
                    Container(height: 4),
                  ]..addAll(headWidget),
                ).paddingAll(16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _playBar() {
    return SliverPersistentHeader(
      // 可以吸顶的TabBar
      pinned: true,
      delegate: HeaderDelegate(
        minHeight: 60,
        maxHeight: 60,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: playBar,
        ),
      ),
    );
  }

  Widget _songList() {
    return Container(
      color: Colors.white,
      child: body,
    );
  }
}
