import 'dart:io';

import 'package:chat_app/src/chat_app_injector.dart';
import 'package:chat_app/src/core/constants.dart';
import 'package:chat_app/src/core/extensions/object_extensions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupaStorageService {
  SupaStorageService._();

  static final SupaStorageService _instance = SupaStorageService._();

  factory SupaStorageService() => _instance;

  final SupabaseStorageClient _supabaseStorage = sl<Supabase>().client.storage;

  Future<String?> uploadProfilePic({
    required File file,
    required String accessToken,
    required String path,
    bool isEdit = false,
  }) async {
    try {
      _supabaseStorage.setAuth(accessToken);
      log('setted access token => ${_supabaseStorage.headers}');
      final resp = await _supabaseStorage.from(Consts.kImagesBucket).upload(
            path,
            file,
            fileOptions: FileOptions(upsert: isEdit),
          );

      log(resp);
      return _supabaseStorage.from(Consts.kImagesBucket).getPublicUrl(path);
    } on Exception catch (e) {
      log('image upload err - $e');
      return null;
    }
  }
}
