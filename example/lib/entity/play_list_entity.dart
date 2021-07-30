class PlayListEntity {
  String? id;
  String? img;
  String? name;
  String? site;
  String? intro;
  String? keepNum;
  String? musicNum;
  String? playNum;
  String? type;
  String? userId;
  String? userName;
  List<String>? tags;

  PlayListEntity({
    this.id,
    this.name,
    this.img,
    this.site,
    this.playNum,
    this.intro,
    this.keepNum,
    this.userId,
    this.userName,
    this.musicNum,
    this.tags,
    this.type,
  });

  PlayListEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    name = json['name'];
    site = json['site'];
    intro = json['intro'];
    keepNum = json['keepNum'];
    musicNum = json['musicNum'];
    playNum = json['playNum'];
    userId = json['userId'];
    userName = json['userName'];
    tags = json['tags'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['img'] = this.img;
    data['name'] = this.name;
    data['site'] = this.site;
    data['intro'] = this.intro;
    data['keepNum'] = this.keepNum;
    data['musicNum'] = this.musicNum;
    data['playNum'] = this.playNum;
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['tags'] = this.tags;
    data['type'] = this.type;
    return data;
  }

  @override
  String toString() {
    return this.name ?? "";
  }
}
