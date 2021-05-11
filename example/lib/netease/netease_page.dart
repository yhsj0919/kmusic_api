import 'package:flutter/material.dart';
import 'package:kmusic_api_example/netease/net_repository.dart';

class NetEasePage extends StatefulWidget {
  @override
  _NetEasePageState createState() => _NetEasePageState();
}

class _NetEasePageState extends State<NetEasePage> with AutomaticKeepAliveClientMixin {
  NetRepository netEase;
  String result = "";

  @override
  void initState() {
    super.initState();
    netEase = NetRepository();
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
                title: Text('登录'),
                onTap: () {
                  netEase.loginByPhone("18612345678", '123456').then(onData).catchError(onError);
                },
              ),
              ListTile(
                title: Text('状态'),
                onTap: () {
                  netEase.loginStatus().then(onData).catchError(onError);
                },
              ),
              ListTile(
                title: Text('歌曲地址'),
                onTap: () {
                  netEase.songurl('1498342485').then(onData).catchError(onError);
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
