import 'package:chat_app/src/core/usecase.dart';
import 'package:chat_app/src/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginUsecase extends Usecase<Either<Exception, User>, LoginParams> {
  final AuthRepository repo;

  LoginUsecase(this.repo);

  @override
  Future<Either<Exception, User>> call(LoginParams params) async {
    return await repo.login(params.email, params.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}
