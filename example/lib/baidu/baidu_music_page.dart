import 'package:flutter/material.dart';
import 'package:kmusic_api_example/qq/qq_repository.dart';

import 'baidu_repository.dart';

class BaiduMusicPage extends StatefulWidget {
  @override
  _BaiduMusicPageState createState() => _BaiduMusicPageState();
}

class _BaiduMusicPageState extends State<BaiduMusicPage> with AutomaticKeepAliveClientMixin {
  BaiduRepository baidu;
  String result = "";

  @override
  void initState() {
    super.initState();
    baidu = BaiduRepository();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 150.0,
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12, width: 1),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: SingleChildScrollView(
              child: Text(result, style: TextStyle(fontSize: 16)),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(bottom: 40),
              children: [
                ListTile(
                  title: Text('开屏广告(可能为空)'),
                  onTap: () {
                    baidu.openScreen().then(onData).catchError(onError);
                  },
                ),
                ListTile(
                  title: Text('首页'),
                  onTap: () {
                    baidu.index().then(onData).catchError(onError);
                  },
                ),
                ListTile(
                  title: Text('专辑列表(最新专辑)'),
                  onTap: () {
                    baidu.albumList().then(onData).catchError(onError);
                  },
                ),
                ListTile(
                  title: Text('专辑详情'),
                  onTap: () {
                    baidu.albumInfo().then(onData).catchError(onError);
                  },
                ),
                ListTile(
                  title: Text('歌曲列表(新歌推荐)'),
                  onTap: () {
                    baidu.songList().then(onData).catchError(onError);
                  },
                ),
                ListTile(
                  title: Text('歌曲详情'),
                  onTap: () {
                    baidu.songInfo().then(onData).catchError(onError);
                  },
                ),
                ListTile(
                  title: Text('歌曲下载'),
                  onTap: () {
                    baidu.songDownload().then(onData).catchError(onError);
                  },
                ),
                ListTile(
                  title: Text('歌手列表'),
                  onTap: () {
                    baidu.artistList().then(onData).catchError(onError);
                  },
                ),
                ListTile(
                  title: Text('歌手信息'),
                  onTap: () {
                    baidu.artistInfo().then(onData).catchError(onError);
                  },
                ),
                ListTile(
                  title: Text('歌手歌曲'),
                  onTap: () {
                    baidu.artistSong().then(onData).catchError(onError);
                  },
                ),
                ListTile(
                  title: Text('歌手专辑'),
                  onTap: () {
                    baidu.artistAlbum().then(onData).catchError(onError);
                  },
                ),
                ListTile(
                  title: Text('搜索'),
                  onTap: () {
                    baidu.search().then(onData).catchError(onError);
                  },
                ),
                ListTile(
                  title: Text('搜索热词'),
                  onTap: () {
                    baidu.searchSug().then(onData).catchError(onError);
                  },
                ),
                ListTile(
                  title: Text('榜单类型'),
                  onTap: () {
                    baidu.bdType().then(onData).catchError(onError);
                  },
                ),
                ListTile(
                  title: Text('榜单歌曲列表'),
                  onTap: () {
                    baidu.bdList().then(onData).catchError(onError);
                  },
                ),
                ListTile(
                  title: Text('歌单分类'),
                  onTap: () {
                    baidu.tracklistType().then(onData).catchError(onError);
                  },
                ),
                ListTile(
                  title: Text('歌单列表'),
                  onTap: () {
                    baidu.tracklistList().then(onData).catchError(onError);
                  },
                ),
                ListTile(
                  title: Text('歌单详情'),
                  onTap: () {
                    baidu.tracklistInfo().then(onData).catchError(onError);
                  },
                ),
                ListTile(
                  title: Text('账户相关(自己测试)'),
                ),
                ListTile(
                  title: Text('视频列表'),
                  onTap: () {
                    baidu.videoList().then(onData).catchError(onError);
                  },
                ),
                ListTile(
                  title: Text('视频详情'),
                  onTap: () {
                    baidu.videoInfo().then(onData).catchError(onError);
                  },
                ),
                ListTile(
                  title: Text('视频推荐'),
                  onTap: () {
                    baidu.videoRecommend().then(onData).catchError(onError);
                  },
                ),
                ListTile(
                  title: Text('视频下载'),
                  onTap: () {
                    baidu.videoDownload().then(onData).catchError(onError);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void onData(value) {
    setState(() {
      result = value.toString();
      print(result);
    });
  }

  void onError(e) {
    setState(() {
      result = e.toString();
      print(result);
    });
  }
}
