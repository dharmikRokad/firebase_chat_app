import 'package:chat_app/src/core/usecase.dart';
import 'package:chat_app/src/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class IsOnboardedUsecase extends Usecase<bool, String> {
  final AuthRepository repo;

  IsOnboardedUsecase(this.repo);

  @override
  Future<bool> call(String params) async {
    final result = await repo.isUserOnBoarded(params);
    return result;
  }
}
