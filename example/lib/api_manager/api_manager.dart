import 'package:flutter/material.dart';
import 'package:kmusic_api_example/baidu/baidu_music_page.dart';
import 'package:kmusic_api_example/migu/migu_page.dart';
import 'package:kmusic_api_example/netease/netease_page.dart';
import 'package:kmusic_api_example/player/player_page.dart';
import 'package:kmusic_api_example/qq/qqmusic_page.dart';
import 'package:kmusic_api_example/server/server_page.dart';
import 'package:kmusic_api_example/widget/app_appbar.dart';

class ApiManagerPage extends StatefulWidget {
  const ApiManagerPage({Key? key}) : super(key: key);

  @override
  _ApiManagerPageState createState() => _ApiManagerPageState();
}

class _ApiManagerPageState extends State<ApiManagerPage> with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return PlayerPage(
        withPlayer: true,
        appBar: AppAppBar(
          title: Text("API测试"),
          centerTitle: true,
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
          ],
        ));
  }
}
