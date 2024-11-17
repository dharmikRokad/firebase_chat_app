import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/firestore_service.dart';
import 'package:chat_app/utils/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationProvider extends ChangeNotifier {
  final AuthService authService;
  final FirestoreService firestoreService;

  AuthenticationProvider(this.authService, this.firestoreService);

  bool _isLoading = false;
  bool _isOnboarded = false;

  bool get isLaoding => _isLoading;
  bool get isOnBoarded => _isOnboarded;

  void changeLoading(bool newValue) {
    _isLoading = newValue;
    notifyListeners();
  }

  Future<bool> isObBoarded(String uid) async {
    _isOnboarded = await firestoreService.isUserOnBoarded(uid: uid);
    if (_isOnboarded) notifyListeners();
    return _isOnboarded;
  }

  Future<void> signIn(
    String email,
    String password, {
    Function(String)? onSuccess,
    Function(String)? onFailure,
  }) async {
    try {
      changeLoading(true);
      final user = await authService.signIn(email: email, password: password);
      onSuccess?.call(user?.uid ?? '');
    } on FirebaseAuthException catch (e) {
      onFailure?.call(e.message ?? '');
    } catch (e) {
      onFailure?.call(Strings.somethingWrong);
    } finally {
      changeLoading(false);
    }
  }

  Future<void> signOut({
    Function(String)? onSuccess,
    Function(String)? onFailure,
  }) async {
    try {
      changeLoading(true);
      await authService.signOut();
      onSuccess?.call(Strings.loggedOut);
    } on FirebaseAuthException catch (e) {
      onFailure?.call(e.code);
    } catch (e) {
      onFailure?.call(Strings.somethingWrong);
    } finally {
      changeLoading(false);
    }
  }

  Stream<User?> authStateChanges() => authService.authStateChanges();
}
