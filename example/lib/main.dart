// import 'package:hive/hive.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kmusic_api_example/baidu/baidu_music_page.dart';
import 'package:kmusic_api_example/baidu/baidu_repository.dart';
import 'package:kmusic_api_example/qq/qq_repository.dart';
import 'package:kmusic_api_example/qq/qqmusic_page.dart';
import 'package:kmusic_api_example/server/server_page.dart';

import 'netease/net_repository.dart';
import 'netease/netease_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('服务测试'),
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 50),
            child: TabBar(
              controller: tabController,
              tabs: [
                Tab(text: '服务'),
                Tab(text: '网易'),
                Tab(text: '百度'),
                Tab(text: '企鹅'),
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
          ],
        ),
      ),
    );
  }
}
