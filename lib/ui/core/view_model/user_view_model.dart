import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/data/local/secure_storage_service.dart';

class UserViewModel extends ChangeNotifier {
  final SecureStorageService _storageService;
  UserViewModel({required SecureStorageService storageService})
    : _storageService = storageService {
    _loadUserInfo();
  }
  String? fullname;
  String? email;

  Future<void> _loadUserInfo() async {
    fullname = await _storageService.getFullName();
    email = await _storageService.getEmail();
    notifyListeners();
  }
}
