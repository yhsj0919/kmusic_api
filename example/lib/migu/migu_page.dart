import 'package:flutter/material.dart';

import 'migu_repository.dart';

class MiGuPage extends StatefulWidget {
  @override
  _MiGuPageState createState() => _MiGuPageState();
}

class _MiGuPageState extends State<MiGuPage>
    with AutomaticKeepAliveClientMixin {
  MiGuRepository miguRepository;
  String result = "";

  @override
  void initState() {
    super.initState();
    miguRepository = MiGuRepository();
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
              children: [
                ListTile(
                  title: Text('新碟上架'),
                  onTap: () {
                    miguRepository.album().then(onData).catchError(onError);
                  },
                ),
                ListTile(
                    title: Text('歌单热门标签'),
                    onTap: () {
                      miguRepository
                          .playListHotTag()
                          .then(onData)
                          .catchError(onError);
                    }),
                ListTile(
                    title: Text('歌单热门推荐(歌单最顶上的几个)'),
                    onTap: () {
                      miguRepository
                          .playListRec()
                          .then(onData)
                          .catchError(onError);
                    }),
                ListTile(
                    title: Text('歌单播放量'),
                    onTap: () {
                      miguRepository
                          .playListPlayNum()
                          .then(onData)
                          .catchError(onError);
                    }),
                ListTile(
                    title: Text('歌单(根据标签ID获取)'),
                    onTap: () {
                      miguRepository
                          .playList()
                          .then(onData)
                          .catchError(onError);
                    }),
                ListTile(
                    title: Text('歌单标签'),
                    onTap: () {
                      miguRepository
                          .playListTagList()
                          .then(onData)
                          .catchError(onError);
                    }),
                ListTile(
                    title: Text('歌单信息'),
                    onTap: () {
                      miguRepository
                          .playListInfo()
                          .then(onData)
                          .catchError(onError);
                    }),
                ListTile(
                    title: Text('歌单歌曲'),
                    onTap: () {
                      miguRepository
                          .playListSong()
                          .then(onData)
                          .catchError(onError);
                    }),
                ListTile(
                    title: Text('播放地址'),
                    onTap: () {
                      miguRepository.playUrl().then(onData).catchError(onError);
                    }),
                ListTile(
                    title: Text('榜单'),
                    onTap: () {
                      miguRepository.topList().then(onData).catchError(onError);
                    }),
                ListTile(
                    title: Text('榜单详情(接口加密,无法访问)'),
                    onTap: () {
                      miguRepository
                          .topListDetail()
                          .then(onData)
                          .catchError(onError);
                    }),
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
