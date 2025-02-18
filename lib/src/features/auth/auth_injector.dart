import 'package:chat_app/src/chat_app_injector.dart';
import 'package:chat_app/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:chat_app/src/features/auth/domain/repository/auth_repository.dart';
import 'package:chat_app/src/features/auth/domain/usecases/is_onboarded_usecase.dart';
import 'package:chat_app/src/features/auth/domain/usecases/log_out_usecase.dart';
import 'package:chat_app/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:chat_app/src/features/auth/presentation/providers/auth_provider.dart';
import 'package:chat_app/src/services/supa_auth_service.dart';
import 'package:chat_app/src/services/supa_database_service.dart';
import 'package:chat_app/src/services/supa_storage_service.dart';
import 'package:flutter/material.dart';

mixin AuthInjector on Injector {
  @override
  @mustCallSuper
  Future<void> init() async {
    await super.init();

    // Providers ================================
    sl.registerLazySingleton(
      () => AuthenticationProvider(
        loginUsecase: sl<LoginUsecase>(),
        logOutUsecase: sl<LogOutUsecase>(),
        isOnboardedUsecase: sl<IsOnboardedUsecase>(),
      ),
    );

    // Usecases ================================
    sl.registerLazySingleton<LoginUsecase>(
      () => LoginUsecase(sl<AuthRepository>()),
    );

    sl.registerLazySingleton<LogOutUsecase>(
      () => LogOutUsecase(sl<AuthRepository>()),
    );

    sl.registerLazySingleton<IsOnboardedUsecase>(
      () => IsOnboardedUsecase(sl<AuthRepository>()),
    );

    // Repositories ================================
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        authService: sl<SupaAuthService>(),
        dbService: sl<SupaDataBaseService>(),
        storageService: sl<SupaStorageService>(),
      ),
    );
  }
}
