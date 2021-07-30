import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/player/player_page.dart';
import 'package:kmusic_api_example/search/search_controller.dart';
import 'package:kmusic_api_example/search/tab/tab_album_page.dart';
import 'package:kmusic_api_example/search/tab/tab_lyric_page.dart';
import 'package:kmusic_api_example/search/tab/tab_playlist_page.dart';
import 'package:kmusic_api_example/search/tab/tab_singer_page.dart';
import 'package:kmusic_api_example/search/tab/tab_song_page.dart';
import 'package:kmusic_api_example/search/tab/tab_video_page.dart';
import 'package:kmusic_api_example/widget/app_appbar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = Get.put(SearchController());
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.addListener(() {
      if (textController.text.isEmpty) {
        searchController.showResult.value = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlayerPage(
      appBar: AppAppBar(
        backgroundColor: Colors.transparent,
        title: searchBar(),
      ),
      body: Obx(
        () => searchController.showResult.value
            ? searchPage()
            : SingleChildScrollView(
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
              ),
      ),
    );
  }

  //搜索详情页
  Widget searchPage() {
    return DefaultTabController(
      length: 6,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            isScrollable: true,
            tabs: [Tab(text: "单曲"), Tab(text: "专辑"), Tab(text: "视频"), Tab(text: "歌单"), Tab(text: "歌词"), Tab(text: "歌手")],
          ),
          Flexible(
            child: TabBarView(
              children: [
                TabSongPage(),
                TabAlbumPage(),
                TabVideoPage(),
                TabPlayListPage(),
                TabLyricPage(),
                TabSingerPage(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget searchBar() {
    return TextField(
      controller: textController,
      // leftOffset: 10,
      // rightOffset: -55,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "请输入关键字",
        prefixIcon: Hero(tag: "tag", child: Icon(Icons.search)),
        suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              textController.text = "";
            }),
      ),
      // optionsBuilder: searchController.searchSuggest,
      textInputAction: TextInputAction.search,
      // displayStringForOption: (dynamic item) => "${item["suggestrecWord"]}",
      // optionsViewBuilder: (_, itemData) => ListTile(title: Text("${itemData["suggestrecWord"]}")),
      onSubmitted: searchController.search,
      // onSelected: (dynamic item) {
      //   searchController.search("${item["suggestrecWord"]}");
      // },
      // onChanged: (value) {
      //   printInfo(info: ">>>>>>>>>>>>>>>>>>>>>");
      //   if (value.isEmpty) {
      //
      //   }
      // },
    );
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
      onPressed: () {
        textController.text = data['word'];
        searchController.showResult.value = true;

        searchController.search("${data['word']}");
      },
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

  @override
  void dispose() {
    super.dispose();
    searchController.showResult.value = false;
  }
}
