import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  FlutterSecureStorage storage = FlutterSecureStorage();

  Future<Map<String, String>> checkTokens() async {
    return await storage.readAll();
  }

  Future<String> getAccessToken() async {
    return await storage.read(key: 'access');
  }

  Future<String> getRefreshToken() async {
    return await storage.read(key: 'refresh');
  }

  // Future setAccessToken() async {}
  Future setNewTokenPair(String access, String refresh) async {
    await storage.write(key: 'access', value: access);
    await storage.write(key: 'refresh', value: refresh);
  }
}
