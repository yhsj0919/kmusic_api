import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/api_manager/api_manager.dart';
import 'package:kmusic_api_example/player/player_controller.dart';
import 'package:kmusic_api_example/search/search_page.dart';
import 'package:kmusic_api_example/widget/app_appbar.dart';
import 'package:kmusic_api_example/widget/app_scaffold.dart';
import 'package:kmusic_api_example/widget/blur_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final playerController = Get.put(PlayerController());

  TabController tabController;

  final banners = ["https://www.migu.cn/assets/pc/images/placeholder-image/banner/music1920x560.jpg", "https://ae01.alicdn.com/kf/Ua5e3b85ad5584245b06b6fbb785df2cdS.jpg"];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      withPlayer: true,
      appBar: AppAppBar(
        leading: const Icon(Icons.menu),
        title: BlurWidget(
          color: Colors.white60,
          height: 30,
          radius: 20,
          shadowColor: Colors.white60,
          elevation: 0,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return SearchPage();
            }));
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return ApiManagerPage();
                }));
              },
              icon: Hero(tag: "tag", child: Icon(Icons.settings)))
        ],
      ),
      body: Column(
        children: [
          BlurWidget(
            radius: 10,
            elevation: 0,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: AspectRatio(
                aspectRatio: 5 / 2,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: banners[index],
                    );
                  },
                  onIndexChanged: (index) {
                    playerController.appBgImageUrl.value = banners[index];
                  },
                  autoplay: true,
                  itemCount: banners.length,
                  // viewportFraction: 0.8,
                  // scale: 0.9,
                  pagination: SwiperPagination(),
                  // control: SwiperControl(),
                )),
          ),
        ],
      ),
    );
  }
}
