import 'package:flutter/material.dart';
import 'package:kmusic_api_example/qq/qq_repository.dart';

class QQMusicPage extends StatefulWidget {
  @override
  _QQMusicPageState createState() => _QQMusicPageState();
}

class _QQMusicPageState extends State<QQMusicPage> with AutomaticKeepAliveClientMixin {
  QQRepository? qqRepository;
  String result = "";

  @override
  void initState() {
    super.initState();
    qqRepository = QQRepository();
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
          ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                title: Text('首页'),
                onTap: () {
                  qqRepository?.home().then(onData).catchError(onError);
                },
              ),
              ListTile(
                title: Text('电台列表'),
                onTap: () {
                  qqRepository?.radioList().then(onData).catchError(onError);
                },
              ),
              ListTile(
                title: Text('MV推荐'),
                onTap: () {
                  qqRepository?.mvRec().then(onData).catchError(onError);
                },
              ),
              ListTile(
                title: Text('搜索建议(周杰伦)'),
                onTap: () {
                  qqRepository?.searchSuggest().then(onData).catchError(onError);
                },
              ),
              ListTile(
                title: Text('搜索(周杰伦)'),
                onTap: () {
                  qqRepository?.search().then(onData).catchError(onError);
                },
              ),
            ],
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
