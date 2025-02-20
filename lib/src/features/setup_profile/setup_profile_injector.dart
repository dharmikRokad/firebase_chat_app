import 'package:chat_app/src/chat_app_injector.dart';
import 'package:chat_app/src/features/setup_profile/data/repository/setup_profile_repo_impl.dart';
import 'package:chat_app/src/features/setup_profile/domain/repository/setup_profile_repo.dart';
import 'package:chat_app/src/features/setup_profile/domain/usecases/send_otp_usecase.dart';
import 'package:chat_app/src/features/setup_profile/domain/usecases/update_profile_usecase.dart';
import 'package:chat_app/src/features/setup_profile/domain/usecases/verify_otp_usecase.dart';
import 'package:chat_app/src/features/setup_profile/presentation/providers/setup_profile_provider.dart';
import 'package:chat_app/src/services/supa_auth_service.dart';
import 'package:chat_app/src/services/supa_database_service.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

mixin SetupProfileInjector on Injector {
  @override
  @mustCallSuper
  Future<void> init() async {
    await super.init();

    // Providers ================================
    sl.registerLazySingleton<SetupProfileProvider>(
      () => SetupProfileProvider(
        sendOtpUsecase: sl<SendOtpUsecase>(),
        verifyOtpUsecase: sl<VerifyOtpUsecase>(),
        updateProfileUseCase: sl<UpdateProfileUsecase>(),
      ),
    );

    // Usecases ================================
    sl.registerLazySingleton<SendOtpUsecase>(
      () => SendOtpUsecase(sl<SetupProfileRepo>()),
    );

    sl.registerLazySingleton<VerifyOtpUsecase>(
      () => VerifyOtpUsecase(sl<SetupProfileRepo>()),
    );

    sl.registerLazySingleton<UpdateProfileUsecase>(
      () => UpdateProfileUsecase(sl<SetupProfileRepo>()),
    );

    // Repositories ================================
    sl.registerLazySingleton<SetupProfileRepo>(
      () => SetupProfileRepoImpl(
        authService: sl<SupaAuthService>(),
        dbService: sl<SupaDataBaseService>(),
      ),
    );
  }
}
