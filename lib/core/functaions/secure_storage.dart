import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String accessTokenKey = 'access_token';

  static Future<void> saveToken(String token) async {
    await _storage.write(key: accessTokenKey, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: accessTokenKey);
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: accessTokenKey);
  }

  static Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
