import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banner/flutter_banner.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/api_manager/api_manager.dart';
import 'package:kmusic_api_example/player/player_controller.dart';
import 'package:kmusic_api_example/player/player_page.dart';
import 'package:kmusic_api_example/search/search_page.dart';
import 'package:kmusic_api_example/widget/app_appbar.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final playerController = Get.put(PlayerController());
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return PlayerPage(
      withPlayer: true,
      imageUrl: playerController.appBgImageUrl,
      opacity: playerController.opacity,
      appBar: AppAppBar(
        leading: const Icon(Icons.menu),
        title: search(),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ApiManagerPage();
                }));
              },
              icon: Hero(tag: "tag", child: Icon(Icons.settings)))
        ],
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 70),
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Obx(() => banner()),
              Row(
                children: [
                  Expanded(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.list_alt, size: 35, color: Color(0xffec3258)),
                    Text("歌单")
                  ])),
                  Expanded(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.bar_chart, size: 35, color: Color(0xffec3258)),
                    Text("榜单")
                  ])),
                  Expanded(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.album, size: 35, color: Color(0xffec3258)),
                    Text("新碟")
                  ])),
                  Expanded(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.person, size: 35, color: Color(0xffec3258)),
                    Text("歌手")
                  ])),
                ],
              ).paddingSymmetric(vertical: 8),
              ListTile(
                title: Text('歌单推荐',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
              Obx(() => playList()),
              ListTile(
                title: Text('新碟上架',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
              Obx(() => album()),
              ListTile(
                title: Text('新歌速递',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
              Obx(() => song()),
            ],
          )),
    );
  }

  Widget search() {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      child: Container(
        width: double.infinity,
        height: 30,
        decoration: BoxDecoration(
          color: Color(0xC000000),
          borderRadius: BorderRadius.all(Radius.circular(30)),
          border: Border.all(color: Color(0xC000000), width: 1),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return SearchPage();
        }));
      },
    );
  }

  Widget banner() {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: homeController.banners.isNotEmpty
          ? KBanner(
              aspectRatio: 750 / 346,
              banners: homeController.banners,
              itemBuilder: (context, value) {
                return CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: value['picUrl'],
                );
              },
              onPageChanged: (value) {
                playerController.opacity.value = 0.2;
                Future.delayed(Duration(milliseconds: 500)).then((_) {
                  playerController.opacity.value = 0.8;
                  playerController.appBgImageUrl.value = value?['picUrl'];
                });
              },
            )
          : AspectRatio(
              aspectRatio: 750 / 346, child: Container(color: Colors.black12)),
    ).marginSymmetric(
      horizontal: 16,
      vertical: 8,
    );
  }

  Widget playList() {
    return Container(
      height: 124,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 8),
          itemCount: homeController.playList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      width: 80,
                      height: 80,
                      child: CachedNetworkImage(
                        imageUrl: homeController.playList[index]['image'],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    width: 80,
                    alignment: Alignment.center,
                    child: Text(
                      homeController.playList[index]['playlistName'],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12),
                      maxLines: 2,
                    ),
                  ),
                ],
              ).marginSymmetric(horizontal: 8),
            );
          }),
    );
  }

  Widget album() {
    return Container(
      height: 106,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 8),
          itemCount: homeController.albums.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    child: Container(
                      width: 80,
                      height: 80,
                      child: CachedNetworkImage(
                        imageUrl: homeController.albums[index]
                            ['albumsSmallUrl'],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    width: 80,
                    alignment: Alignment.center,
                    child: Text(
                      homeController.albums[index]['albumName'],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12),
                      maxLines: 1,
                    ),
                  ),
                ],
              ).marginSymmetric(horizontal: 8),
            );
          }),
    );
  }

  Widget song() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: homeController.songs.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Get.printError(info: json.encode(homeController.songs[index]));
            homeController.play(homeController.songs[index]);
          },
          leading: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Container(
              width: 50,
              height: 50,
              child: CachedNetworkImage(
                imageUrl: homeController.songs[index]['picS'],
              ),
            ),
          ),
          title: Text(
            homeController.songs[index]['songName'],
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          subtitle: Text(
            (homeController.songs[index]['singerName'] as List).join(","),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12),
            maxLines: 1,
          ),
        );
      },
    );
  }
}
