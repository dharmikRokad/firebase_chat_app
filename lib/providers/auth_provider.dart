import 'dart:developer';
import 'dart:io';

import 'package:chat_app/services/supa_auth_service.dart';
import 'package:chat_app/services/supa_database_service.dart';
import 'package:chat_app/services/supa_storage_service.dart';
import 'package:chat_app/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationProvider extends ChangeNotifier {
  final SupaAuthService supaAuthService;
  final SupaDataBaseService supaDatabaseService;
  final SupaStorageService supaStorageService;

  AuthenticationProvider(
    this.supaAuthService,
    this.supaDatabaseService,
    this.supaStorageService,
  ) {
    _me = supaAuthService.getCurrentUser;
    _currentSession = supaAuthService.currentSession;
    log('[AuthenticationProvider] current session => $_currentSession');
  }

  bool _isLoading = false;
  bool _isOnboarded = false;
  late User? _me;
  late Session? _currentSession;

  XFile? _profilePic;
  DateTime? _dob;
  String? _gender;

  bool get isLaoding => _isLoading;
  bool get isOnBoarded => _isOnboarded;
  User? get me => _me;
  Session? get currentSession => _currentSession;

  XFile? get profilePic => _profilePic;
  DateTime? get dob => _dob;
  String? get gender => _gender;

  void changeLoading(bool newValue) {
    _isLoading = newValue;
    notifyListeners();
  }

  Future<bool> isObBoarded(String uid) async {
    try {
      _isOnboarded = await supaDatabaseService.isUserOnBoarded(uid: uid);
      if (_isOnboarded) notifyListeners();
      return _isOnboarded;
    } on PostgrestException catch (e) {
      log('Error while checking if user is onboarded: $e');
      return false;
    } catch (e) {
      log('Error while checking if user is onboarded: $e');
      return false;
    }
  }

  void setProfilePic(XFile? value) {
    _profilePic = value;
    notifyListeners();
  }

  void setDob(DateTime? value) {
    _dob = value;
    notifyListeners();
  }

  void setGender(String? value) {
    _gender = value;
    notifyListeners();
  }

  void resetValues() {
    _profilePic = null;
    _dob = null;
    _gender = null;
    notifyListeners();
  }

  Future<void> signIn(
    String email,
    String password, {
    Function(String)? onSuccess,
    Function(String)? onFailure,
  }) async {
    try {
      changeLoading(true);
      _me = await supaAuthService.signIn(email: email, password: password);
      onSuccess?.call(_me?.id ?? '');
    } on AuthException catch (e) {
      log(e.toString());
      onFailure?.call(e.message);
    } catch (e) {
      log(e.toString());
      onFailure?.call(Strings.somethingWrong);
    } finally {
      changeLoading(false);
    }
  }

  Future<String?> uploadProfilePick({
    Function(String)? onSuccess,
    Function(String)? onFailure,
  }) async {
    try {
      changeLoading(true);

      if (_currentSession == null) {
        onFailure?.call(Strings.loginFirst);
        return null;
      }

      return await supaStorageService.uploadProfilePic(
          file: File(_profilePic?.path ?? ''),
          id: _me?.id ?? '',
          accessToken: _currentSession?.accessToken ?? '');
    } on StorageException catch (e) {
      log('Error - uploading photo => ${e.message}');
      onFailure?.call(e.message);
      return null;
    } catch (e) {
      log('Error - uploading photo => {e.toString()');
      onFailure?.call(Strings.somethingWrong);
      return null;
    } finally {
      changeLoading(false);
    }
  }

  Future<void> updateProfile(
    Map<String, dynamic> data, {
    Function(String)? onSuccess,
    Function(String)? onFailure,
  }) async {
    try {
      changeLoading(true);
      await supaDatabaseService.updateProfile(
        uid: _me?.id ?? '',
        email: _me?.email ?? '',
        data: data,
      );
      onSuccess?.call(Strings.profileUpdated);
    } on PostgrestException catch (e) {
      log('Error - update profile => ${e.message}');
      onFailure?.call(e.message);
    } on Exception catch (e) {
      log('Error - update profile => ${e.toString()}');
      onFailure?.call(Strings.somethingWrong);
    } finally {
      changeLoading(true);
    }
  }

  Future<void> signOut({
    Function(String)? onSuccess,
    Function(String)? onFailure,
  }) async {
    try {
      changeLoading(true);
      await supaAuthService.signOut();
      resetValues();
      onSuccess?.call(Strings.loggedOut);
    } on AuthException catch (e) {
      log(e.toString());
      onFailure?.call(e.message);
    } catch (e) {
      log(e.toString());
      onFailure?.call(Strings.somethingWrong);
    } finally {
      changeLoading(false);
    }
  }

  Stream<AuthState?> authStateChanges() => supaAuthService.authStateChanges();
}
