
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmusic_api_example/player/player_controller.dart';

class PlayPage extends StatelessWidget {
  PlayPage({Key? key}) : super(key: key);

  final player = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
