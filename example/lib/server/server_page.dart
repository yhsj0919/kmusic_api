import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kmusic_api/kmusic_api.dart';

class ServerPage extends StatefulWidget {
  @override
  _ServerPageState createState() => _ServerPageState();
}

class _ServerPageState extends State<ServerPage> with AutomaticKeepAliveClientMixin {


  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text('服务能单独使用，输入本机ip端口号即可访问'),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(FontAwesomeIcons.server),
              Container(
                width: 16,
              ),
              Container(
                width: 120,
                child: Text(
                  '${  KMusic.ip()}:${KMusic.port()}',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 16),
            child: TextButton(
              onPressed: () async {
              KMusic.startServer(address: '0.0.0.0', port: 3001)?.then((value){
                setState(() {});
              });
              },
              child: Text(
                '开启服务：3001',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              KMusic.stopServer()?.then((value) {
                setState(() {});
              });
            },
            child: Text(
              '关闭服务',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

}
