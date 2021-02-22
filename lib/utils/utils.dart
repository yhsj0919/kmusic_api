import 'dart:collection';

bool toBoolean(val) {
  if (val == '') return val;
  return val == 'true' || val == '1';
}

String toParamsString(LinkedHashMap params) {
  return params.entries.map((e) => "${e.key}=${e.value}").join("&");
}
