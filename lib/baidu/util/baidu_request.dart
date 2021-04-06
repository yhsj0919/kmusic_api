import 'dart:async';
import 'dart:collection';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:kmusic_api/utils/answer.dart';
import 'package:kmusic_api/utils/request.dart';
import 'package:kmusic_api/utils/utils.dart';

import '../../baidu_music.dart';

String paramsSign(String params) {
  final secret = "0b50b02fd0d73a9c4c8c3a781c30845f";

  return md5.convert(utf8.encode("$params$secret")).toString();
}

Future<Answer> request(
  String method,
  String url,
  LinkedHashMap data, {
  String authorization = '',
}) async {
  final headers = {
    "app-version": "v8.2.3.1",
    "from": "android",
    "user-agent": "Mozilla/5.0 (Linux; U; Android 8.0.0; zh-cn; MI 5 Build/OPR1.170623.032) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30",
  };

  if (authorization.isNotEmpty) {
    headers["authorization"] = "/access_token $authorization";
  }

  var timestamp = DateTime.now().millisecondsSinceEpoch;
  data["timestamp"] = "$timestamp";

  var sign = paramsSign(toParamsString(data));

  if (method == "POST") {
    url = "$url?sign=$sign&timestamp=$timestamp";
  }
  if (method == "GET") {
    data["sign"] = sign;
    url = url + "?${toParamsString(data)}";
    data = LinkedHashMap();
  }

  return httpRequest(url, headers, data, method).then((response) async {
    var ans = Answer(cookie: response.cookies);

    final content = await response.cast<List<int>>().transform(utf8.decoder).join();
    print(content);
    final body = json.decode(content);
    ans = ans.copy(status: response.statusCode, body: body);

    ans = ans.copy(status: ans.status > 100 && ans.status < 600 ? ans.status : 400);
    return ans;
  }).catchError((e, s) {
    debugPrint(e.toString());
    debugPrint(s.toString());
    return Answer(status: 502, body: {'code': 502, 'msg': e.toString()});
  });
}
