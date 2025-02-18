import 'package:chat_app/src/services/supa_database_service.dart';
import 'package:chat_app/src/services/supa_storage_service.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:chat_app/src/services/supa_auth_service.dart';
import 'package:chat_app/src/core/extensions/object_extensions.dart';
import 'package:chat_app/src/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final SupaAuthService authService;
  final SupaDataBaseService dbService;
  final SupaStorageService storageService;

  AuthRepositoryImpl(
      {required this.authService,
      required this.dbService,
      required this.storageService});

  @override
  Future<Either<Exception, User>> login(String email, String password) async {
    try {
      final user = await authService.signIn(email: email, password: password);
      if (user != null) return Right(user);
      return Left(Exception('Something went wrong.'));
    } on Exception catch (e) {
      log("login err - $e");
      return Left(e);
    }
  }

  @override
  Future<Either<Exception, bool>> logOut() async {
    try {
      await authService.signOut();
      return const Right(true);
    } on Exception catch (e) {
      log("log out err - $e");
      return left(e);
    }
  }

  @override
  Future<bool> isUserOnBoarded(String uid) async {
    try {
      return await dbService.isUserOnBoarded(uid: uid);
    } on Exception catch (e) {
      log("is onboarded err - $e");
      return false;
    }
  }
}
