import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kmusic_api/kmusic_api.dart';

void main() {
  const MethodChannel channel = MethodChannel('kmusic_api');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {

  });
}
