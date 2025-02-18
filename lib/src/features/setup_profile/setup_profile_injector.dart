import 'package:chat_app/src/chat_app_injector.dart';
import 'package:chat_app/src/features/setup_profile/data/repository/setup_profile_repo_impl.dart';
import 'package:chat_app/src/features/setup_profile/domain/repository/setup_profile_repo.dart';
import 'package:chat_app/src/features/setup_profile/domain/usecases/update_profile_usecase.dart';
import 'package:chat_app/src/features/setup_profile/presentation/providers/setup_profile_provider.dart';
import 'package:chat_app/src/services/supa_database_service.dart';
import 'package:flutter/material.dart';

mixin SetupProfileInjector on Injector {
  @override
  @mustCallSuper
  Future<void> init() async {
    await super.init();

    // Providers ================================
    sl.registerLazySingleton<SetupProfileProvider>(
      () => SetupProfileProvider(
        updateProfileUseCase: sl<UpdateProfileUsecase>(),
      ),
    );

    // Usecases ================================
    sl.registerLazySingleton<UpdateProfileUsecase>(
      () => UpdateProfileUsecase(sl<SetupProfileRepo>()),
    );

    // Repositories ================================
    sl.registerLazySingleton<SetupProfileRepo>(
      () => SetupProfileRepoImpl(
        dbService: sl<SupaDataBaseService>(),
      ),
    );
  }
}
