import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const _keyToken = "auth_token";
  static const _keyFullName = "user_fullname";
  static const _keyMyId = "my_id";
  static const _keyEmail = "user_email";
  static const _keyPassword = "user_password";
  static const _keyRememberMe = "remember_me";

  Future<void> saveToken(String token) async {
    await _storage.write(key: _keyToken, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: _keyToken);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _keyToken);
  }

  Future<void> saveEmail(String email) async {
    await _storage.write(key: _keyEmail, value: email);
  }

  Future<String?> getEmail() async {
    return await _storage.read(key: _keyEmail);
  }

  Future<void> deleteEmail() async {
    await _storage.delete(key: _keyEmail);
  }

  Future<void> savePassword(String password) async {
    await _storage.write(key: _keyPassword, value: password);
  }

  Future<String?> getPassword() async {
    return await _storage.read(key: _keyPassword);
  }

  Future<void> deletePassword() async {
    await _storage.delete(key: _keyPassword);
  }

  Future<void> saveRememberMe(bool rememberMe) async {
    await _storage.write(key: _keyRememberMe, value: rememberMe.toString());
  }

  Future<bool> getRememberMe() async {
    String? value = await _storage.read(key: _keyRememberMe);
    return value == 'true';
  }

  Future<void> deleteRememberMe() async {
    await _storage.delete(key: _keyRememberMe);
  }

  Future<void> saveFullName(String fullName) async {
    await _storage.write(key: _keyFullName, value: fullName);
  }

  Future<String?> getFullName() async {
    return await _storage.read(key: _keyFullName);
  }

  Future<void> deleteFullName() async {
    await _storage.delete(key: _keyFullName);
  }

  Future<void> saveMyId(String id) async {
    await _storage.write(key: _keyMyId, value: id);
  }

  Future<String?> getMyId() async {
    return await _storage.read(key: _keyMyId);
  }

  Future<void> deleteMyId() async {
    await _storage.delete(key: _keyMyId);
  }
}
