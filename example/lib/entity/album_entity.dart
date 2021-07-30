import 'package:kmusic_api_example/entity/singer_entity.dart';

class AlbumEntity {
  String? id;
  String? img;
  String? name;
  String? site;
  String? desc;
  String? time;
  String? company;
  String? totalCount;
  String? language;
  String? albumClass;
  String? type;
  List<SingerEntity>? singer;

  AlbumEntity({
    this.id,
    this.name,
    this.img,
    this.site,
    this.desc,
    this.singer,
    this.time,
    this.company,
    this.totalCount,
    this.language,
    this.albumClass,
    this.type,
  });

  AlbumEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    name = json['name'];
    site = json['site'];
    desc = json['desc'];
    singer = json['singer'];
    time = json['time'];
    company = json['company'];
    totalCount = json['totalCount'];
    language = json['language'];
    albumClass = json['albumClass'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['img'] = this.img;
    data['name'] = this.name;
    data['site'] = this.site;
    data['desc'] = this.desc;
    data['singer'] = this.singer;
    data['time'] = this.time;
    data['company'] = this.company;
    data['totalCount'] = this.totalCount;
    data['language'] = this.language;
    data['albumClass'] = this.albumClass;
    data['type'] = this.type;
    return data;
  }

  @override
  String toString() {
    return this.name ?? "";
  }
}
