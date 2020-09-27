import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  FlutterSecureStorage _storage = FlutterSecureStorage();

  Future deleteTokens() async {
    await _storage.deleteAll();
  }

  Future<Map<String, String>> checkTokens() async {
    return await _storage.readAll();
  }

  Future<String> getAccessToken() async {
    return await _storage.read(key: 'access');
  }

  Future<String> getRefreshToken() async {
    return await _storage.read(key: 'refresh');
  }

  // Future setAccessToken() async {}
  Future setNewTokenPair(String access, String refresh) async {
    await _storage.write(key: 'access', value: access);
    await _storage.write(key: 'refresh', value: refresh);
  }
}
