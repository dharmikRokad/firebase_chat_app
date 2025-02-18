import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  Future<Either<Exception, User>> login(String email, String password);
  Future<Either<Exception, bool>> logOut();

  Future<bool> isUserOnBoarded(String uid);
}
