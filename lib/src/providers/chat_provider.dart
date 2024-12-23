import 'package:chat_app/src/services/supa_auth_service.dart';
import 'package:chat_app/src/services/supa_database_service.dart';
import 'package:chat_app/src/services/supa_storage_service.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  final SupaAuthService supaAuthService;
  final SupaDataBaseService supaDatabaseService;
  final SupaStorageService supaStorageService;

  ChatProvider(
    this.supaAuthService,
    this.supaDatabaseService,
    this.supaStorageService,
  );

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void changeLoading(bool newValue) {
    _isLoading = newValue;
    notifyListeners();
  }

  Stream<List<Map<String, dynamic>>> getUsers() {
    return supaDatabaseService.getUsers();
  }
}
