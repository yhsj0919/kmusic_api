import 'dart:io';

import 'package:kmusic_api/migu/util/migu_request.dart';
import 'package:kmusic_api/utils/answer.dart';

part 'module/album.dart';

typedef Handler = Future<Answer> Function(Map query, List<Cookie> cookie);

final handles = <String, Handler>{
  "/album": album,
};
