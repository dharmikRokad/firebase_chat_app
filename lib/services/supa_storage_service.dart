import 'dart:developer';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class SupaStorageService {
  SupaStorageService._();

  static final SupaStorageService _instance = SupaStorageService._();

  factory SupaStorageService() => _instance;

  final SupabaseStorageClient _supaStorage = Supabase.instance.client.storage;

  Future<String> uploadProfilePic(File file, String id) async {
    final String fileName = '$id-${DateTime.now().millisecondsSinceEpoch}.jpg';
    final resp = await _supaStorage.from('profile_pics').upload(
          fileName,
          file,
          fileOptions: const FileOptions(upsert: true),
        );

    log(resp);
    return _supaStorage.from('profile_pics').getPublicUrl(fileName);
  }
}
