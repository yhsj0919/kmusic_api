class SingerEntity {
  String? id;
  String? img;
  String? name;
  String? site;

  SingerEntity({this.id, this.name, this.img, this.site});

  SingerEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    name = json['name'];
    site = json['site'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['img'] = this.img;
    data['name'] = this.name;
    data['site'] = this.site;
    return data;
  }

  @override
  String toString() {
    return this.name??"";
  }
}
