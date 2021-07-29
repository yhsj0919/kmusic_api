import 'package:kmusic_api_example/entity/singer_entity.dart';

class SongEntity {
  String? code;
  String? msg;
  String? id;
  String? img;
  String? name;
  String? url;
  String? site;
  bool? hasMv;
  String? mvId;
  String? lrc;
  String? album;
  String? albumId;
  List<SingerEntity>? singer;

  SongEntity({this.id, this.name, this.img, this.url, this.singer, this.site, this.hasMv: false, this.mvId, this.lrc, this.album, this.albumId, this.code: "000000", this.msg});

  SongEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    id = json['id'];
    img = json['img'];
    name = json['name'];
    singer = json['singer'];
    url = json['url'];
    site = json['site'];
    hasMv = json['hasMv'];
    mvId = json['mvId'];
    lrc = json['lrc'];
    albumId = json['albumId'];
    album = json['album'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    data['id'] = this.id;
    data['img'] = this.img;
    data['name'] = this.name;
    data['singer'] = this.singer;
    data['url'] = this.url;
    data['site'] = this.site;
    data['hasMv'] = this.hasMv;
    data['mvId'] = this.mvId;
    data['lrc'] = this.lrc;
    data['album'] = this.album;
    data['albumId'] = this.albumId;
    return data;
  }
}
