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
          ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                title: Text('搜索'),
                onTap: () {
                  baidu.search().then(onData).catchError(onError);
                },
              ),
            ],
          )
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
