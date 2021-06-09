import 'package:get/get.dart';
import 'package:kmusic_api_example/migu/migu_repository.dart';

class SearchController extends GetxController {
  final migu = MiGuRepository();

  RxList hotwords = RxList();
  RxList discovery = RxList();

  @override
  void onInit() {
    super.onInit();
    searchHotWord();
  }

  void searchHotWord() {
    migu.searchHotWord().then((value) {
      hotwords.addAll(value["data"]["hotwords"][0]["hotwordList"] as List);
      discovery.addAll(value["data"]["discovery"] as List);
    });
  }
}
