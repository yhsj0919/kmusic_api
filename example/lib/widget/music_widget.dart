import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kmusic_api_example/widget/app_image.dart';

Widget songItem({String? img, String? title, String? subtitle, GestureTapCallback? onTap}) {
  return ListTile(
    onTap: onTap,
    leading: img == null ? null : AppImage(width: 50, height: 50, radius: 10, url: img),
    title: Text(title ?? "", overflow: TextOverflow.ellipsis, maxLines: 1),
    subtitle: Text(subtitle ?? "", overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12), maxLines: 1),
    trailing: Material(
        color: Colors.transparent,
        child: Ink(
            child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            child: Icon(Icons.more_vert),
          ),
          onTap: () {},
        ))),
  );
}
