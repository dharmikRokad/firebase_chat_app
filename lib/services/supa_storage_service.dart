import 'dart:io';

import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/utils/extensions/object_extensions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupaStorageService {
  SupaStorageService._();

  static final SupaStorageService _instance = SupaStorageService._();

  factory SupaStorageService() => _instance;

  final SupabaseStorageClient _supabaseStorage =
      Supabase.instance.client.storage;

  Future<String> uploadProfilePic({
    required File file,
    required String id,
    required String accessToken,
    bool isEdit = false,
  }) async {
    _supabaseStorage.setAuth(accessToken);
    this.log('setted access token => ${_supabaseStorage.headers}');
    final String path = '${Consts.kProfilePicsFolder}/$id';
    final resp = await _supabaseStorage.from(Consts.kImagesBucket).upload(
          path,
          file,
          fileOptions: FileOptions(upsert: isEdit),
        );

    this.log(resp);
    return _supabaseStorage.from(Consts.kImagesBucket).getPublicUrl(path);
  }
}
