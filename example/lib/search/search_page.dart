import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/player/player_page.dart';
import 'package:kmusic_api_example/search/search_controller.dart';
import 'package:kmusic_api_example/widget/blur_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return PlayerPage(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleSpacing: 0,
          title: TextField(
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              print("$value");
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "请输入关键字",
              prefixIcon: Hero(tag: "tag", child: Icon(Icons.search)),
              suffixIcon: Icon(Icons.clear),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 70),
          physics: BouncingScrollPhysics(),
          child: Obx(
            () => Column(
              children: [
                discovery(),
                hotWord(),
              ],
            ),
          ),
        ));
  }

  ///热门搜索
  Widget hotWord() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "实时热搜",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ).paddingSymmetric(horizontal: 16, vertical: 8),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: searchController.hotwords.length,
          itemBuilder: hotWordItem,
        ),
      ],
    );
  }

  //热门搜索item
  Widget hotWordItem(context, index) {
    return ListTile(
      onTap: () {},
      title: Text(
        "${index + 1}   " + searchController.hotwords[index]['word'],
        style: TextStyle(fontSize: 14, color: index < 3 ? Colors.black : Color(0xff666666)),
      ),
      trailing: Text(
        searchController.hotwords[index]['note'],
        style: TextStyle(fontSize: 14, color: Color(0xff999999)),
      ),
    );
  }

  ///发现
  Widget discovery() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            "搜索发现",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Wrap(
          spacing: 10,
          runSpacing: 4,
          children: searchController.discovery.map(discoveryButton).toList(),
        ).paddingSymmetric(horizontal: 16, vertical: 8),
      ],
    );
  }

  ///发现内部按钮
  Widget discoveryButton(data) {
    return MaterialButton(
      onPressed: () {},
      child: Text(
        data['word'],
        style: TextStyle(fontSize: 13),
      ),
      elevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      focusElevation: 0,
      color: Color(0xffeeeeee),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}
