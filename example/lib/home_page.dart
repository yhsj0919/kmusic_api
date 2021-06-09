import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kmusic_api_example/qq/qqmusic_page.dart';
import 'package:kmusic_api_example/search/search_page.dart';
import 'package:kmusic_api_example/server/server_page.dart';
import 'package:kmusic_api_example/widget/blur_widget.dart';

import 'baidu/baidu_music_page.dart';
import 'migu/migu_page.dart';
import 'netease/netease_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  TabController tabController;
  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: BlurWidget(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            titleSpacing: 0,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: const Icon(Icons.menu),
            title: BlurWidget(
              color: Colors.white,
              height: 30,
              borderWidth: 1,
              radius: 20,
              elevation: 0,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return SearchPage();
                }));
              },
            ),
            actions: [IconButton(onPressed: () {}, icon: Hero(tag: "tag", child: Icon(Icons.settings)))],
            bottom: PreferredSize(
              preferredSize: Size(double.infinity, 50),
              child: TabBar(
                isScrollable: true,
                controller: tabController,
                tabs: [
                  Tab(text: '服务'),
                  Tab(text: '网易'),
                  Tab(text: '百度'),
                  Tab(text: '企鹅'),
                  Tab(text: '咪咕'),
                  Tab(text: '测试'),
                ],
              ),
            ),
          ),
          body: TabBarView(
            controller: tabController,
            children: [
              ServerPage(),
              NetEasePage(),
              BaiduMusicPage(),
              QQMusicPage(),
              MiGuPage(),
              Container(
                child: TextButton(
                  child: Text('播放'),
                  onPressed: play,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> play() async {
    try {
      await assetsAudioPlayer.open(
          Audio.network(
            "http://freetyst.nf.migu.cn/public/product9th/product41/2020/09/0817/2015%E5%B9%B410%E6%9C%8814%E6%97%A515%E7%82%B905%E5%88%86%E5%86%85%E5%AE%B9%E5%87%86%E5%85%A5SONY999%E9%A6%96/%E6%A0%87%E6%B8%85%E9%AB%98%E6%B8%85/MP3_320_16_Stero/6005970EYGK174553.mp3?channelid=03&k=04aeb50690d824e4&t=1623224972&msisdn=b83a5578-b62b-4365-975f-840b42c29413",
            metas: Metas(
              title: "Swagger",
              artist: "Angie Johnson",
              album: "Sing For You",
              image: MetasImage.network(
                  "http://d.musicapp.migu.cn/prod/file-service/file-down/8121e8df41a5c12f48b69aea89b71dab/c6ac1a8cc5242f77cae0f06302aa6430/3f09149f95923cfd31f9b558bb48c74d"), //can be MetasImage.network
            ),
          ),
          showNotification: true);
    } catch (t) {
      //mp3 unreachable
    }
  }
}
