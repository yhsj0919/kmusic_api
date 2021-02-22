import 'dart:collection';

import 'package:kmusic_api/baidu/util/baidu_request.dart';

part 'module/test.dart';

typedef Handler = Future<dynamic> Function(Map query, String auth);

final handles = <String, Handler>{
  "/test": test,
};
