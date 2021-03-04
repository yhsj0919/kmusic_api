import 'dart:io';

import 'package:kmusic_api/utils/answer.dart';

import 'qq/module.dart';

typedef DebugPrinter = void Function(String message);

DebugPrinter debugPrint = (msg) {
  print(msg);
};

/// QQ音乐 API
Future<dynamic> qqMusicApi(
    String path, {
      Map parameter,
      List<Cookie> cookie = const [],
    }) async {
  // assert(path != null, "path can not be null");
  // assert(handles.containsKey(path), "此 api url 未被定义, 请检查: $path ");
  if (!handles.containsKey(path)) {
    return Answer()
        .copy(body: {'code': 500, 'msg': "此 api url 未被定义, 请检查: $path "});
  }
  final Handler handle = handles[path];

  try {
    final answer = await handle(parameter, cookie);
    return answer;
  } on HttpException catch (e, stack) {
    debugPrint(e.toString());
    debugPrint(stack.toString());
    rethrow;
  }
}