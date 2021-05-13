import 'package:flutter/material.dart';
import 'package:kmusic_api_example/qq/qqmusic_page.dart';
import 'package:kmusic_api_example/server/server_page.dart';

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

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('服务测试'),
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
      ),
    );
  }
}
