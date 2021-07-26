import 'package:get/get.dart';
import 'package:kmusic_api_example/home/home_page.dart';
import 'package:kmusic_api_example/play_list/play_list_detail_page.dart';
import 'package:kmusic_api_example/search/search_page.dart';

class Routes {
  static const String HOME = "/home";
  static const String SEARCH = "/search";
  static const String PLAY_LIST_DETAIL = "/playListDetail";

  static List<GetPage> routes = [
    GetPage(name: HOME, page: () => HomePage()),
    GetPage(name: SEARCH, page: () => SearchPage()),
    GetPage(name: PLAY_LIST_DETAIL, page: () => PlayListDetailPage()),
  ];
}
