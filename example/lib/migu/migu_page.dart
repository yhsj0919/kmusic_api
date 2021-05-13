import 'package:flutter/material.dart';

import 'migu_repository.dart';

class MiGuPage extends StatefulWidget {
  @override
  _MiGuPageState createState() => _MiGuPageState();
}

class _MiGuPageState extends State<MiGuPage> with AutomaticKeepAliveClientMixin {
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
          ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                title: Text('新碟上架'),
                onTap: () {
                  miguRepository.album().then(onData).catchError(onError);
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
