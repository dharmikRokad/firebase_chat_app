import 'package:chat_app/src/chat_app_injector.dart';
import 'package:chat_app/src/core/shared_prefs.dart';
import 'package:chat_app/src/core/usecase.dart';
import 'package:chat_app/src/features/auth/domain/usecases/is_onboarded_usecase.dart';
import 'package:chat_app/src/features/auth/domain/usecases/log_out_usecase.dart';
import 'package:chat_app/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:chat_app/src/features/setup_profile/domain/usecases/update_profile_usecase.dart';
import 'package:chat_app/src/services/supa_auth_service.dart';
import 'package:chat_app/src/core/strings.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationProvider extends ChangeNotifier {
  final LoginUsecase loginUsecase;
  final LogOutUsecase logOutUsecase;
  final IsOnboardedUsecase isOnboardedUsecase;

  AuthenticationProvider({
    required this.loginUsecase,
    required this.logOutUsecase,
    required this.isOnboardedUsecase,
  });

  // Class Fields ================================
  bool _isLoading = false;
  User? _me;

  // Getters ================================
  bool get isLaoding => _isLoading;
  User? get me => _me;
  Session? get currentSession => sl<SupaAuthService>().currentSession;

  // Setter Functions ================================
  void changeLoading(bool newValue) {
    _isLoading = newValue;
    notifyListeners();
  }

  // Class Functions ================================
  Future<bool> isObBoarded(String uid) async => await isOnboardedUsecase(uid);

  Future<void> signIn(
    String email,
    String password, {
    Function(String)? onSuccess,
    Function(String)? onFailure,
  }) async {
    changeLoading(true);
    final result = await loginUsecase.call(LoginParams(
      email: email,
      password: password,
    ));
    result.fold(
      (err) => onFailure?.call(err.toString()),
      (user) {
        _me = user;
        onSuccess?.call(_me?.id ?? '');
      },
    );
    changeLoading(false);
  }

  Future<void> signOut({
    Function(String)? onSuccess,
    Function(String)? onFailure,
  }) async {
    changeLoading(true);
    final result = await logOutUsecase.call(NoParams());
    result.fold(
      (err) => onFailure?.call(err.toString()),
      (value) {
        onSuccess?.call(Strings.loggedOut);
      },
    );
    changeLoading(false);
  }

  Stream<AuthState?> authStateChanges() =>
      sl<SupaAuthService>().authStateChanges();
}
