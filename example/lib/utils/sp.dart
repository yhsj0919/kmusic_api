import 'dart:convert';

import 'package:get_storage/get_storage.dart';

/// 本地存储
class Sp {
  static Sp _instance = new Sp._();

  factory Sp() => _instance;
  static GetStorage _prefs;

  Sp._();

  static void init() async {
    GetStorage.init().then((value) {
      if (value) {
        _prefs = GetStorage();
      }
    });
  }

  Future<void> set(String key, dynamic jsonVal) {
    return _prefs.write(key, jsonVal);
  }

  T get<T>(String key) {
    return _prefs.read(key);
  }

  Future<bool> remove(String key) {
    return _prefs.remove(key);
  }
}
