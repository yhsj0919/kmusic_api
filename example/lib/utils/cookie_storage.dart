import 'dart:typed_data';
import 'package:cookie_jar/src/stroage.dart';
import 'package:get_storage/get_storage.dart';

///Save cookies in  files

class CookieStorage implements Storage {
  CookieStorage([this._storageName]);

  String _storageName;

  GetStorage _storage;

  String Function(Uint8List list) readPreHandler;

  List<int> Function(String value) writePreHandler;

  @override
  Future<void> delete(String key) async {
    return _storage.remove(key);
  }

  @override
  Future<void> deleteAll(List<String> keys) async {
    keys.forEach((element) {
      _storage.remove(element);
    });
  }

  @override
  Future<void> init(bool persistSession, bool ignoreExpires) async {
    _storageName = _storageName ?? 'GetCookie';
    _storageName = _storageName + 'ie${ignoreExpires ? 1 : 0}_ps${persistSession ? 1 : 0}';
    _storage = GetStorage(_storageName);
  }

  @override
  Future<String> read(String key) async {
    if (readPreHandler != null) {
      return readPreHandler(_storage.read(key));
    } else {
      return _storage.read(key);
    }
  }

  @override
  Future<void> write(String key, String value) async {
    if (writePreHandler != null) {
      return _storage.write(key, writePreHandler(value));
    } else {
      return _storage.write(key, value);
    }
  }
}
