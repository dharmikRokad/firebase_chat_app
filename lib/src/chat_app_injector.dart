import 'package:chat_app/src/core/shared_prefs.dart';
import 'package:chat_app/src/features/auth/auth_injector.dart';
import 'package:chat_app/src/features/setup_profile/setup_profile_injector.dart';
import 'package:chat_app/src/services/supa_auth_service.dart';
import 'package:chat_app/src/services/supa_database_service.dart';
import 'package:chat_app/src/services/supa_storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

class ChatAppInjector extends Injector
    with AuthInjector, SetupProfileInjector {}

abstract class Injector {
  @mustCallSuper
  Future<void> init() async {
    sl.registerSingletonAsync<Supabase>(
      () async => await Supabase.initialize(
        anonKey: dotenv.env["SB_ANON_KEY"] ?? '',
        url: dotenv.env["SB_PUB_URL"] ?? '',
      ).then((_) {
        return Supabase.instance;
      }),
    );

    sl.registerSingletonAsync<SharedPrefs>(
        () async => SharedPrefs.instance..init());

    sl.registerLazySingleton<SupaAuthService>(() => SupaAuthService());

    sl.registerLazySingleton<SupaStorageService>(() => SupaStorageService());

    sl.registerLazySingleton<SupaDataBaseService>(() => SupaDataBaseService());
  }
}
