import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/search/search_controller.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Obx(
        () => SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "搜索发现",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ).paddingSymmetric(horizontal: 16, vertical: 8),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: searchController.discovery
                    .map((element) => MaterialButton(
                          onPressed: () {},
                          child: Text(
                            element['word'],
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
                        ))
                    .toList(),
              ).marginOnly(left: 16, right: 16, bottom: 8),
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
                itemBuilder: (context, index) {
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
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
