import 'package:chat_app/src/core/usecase.dart';
import 'package:chat_app/src/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LogOutUsecase extends Usecase<Either<Exception, bool>, NoParams> {
  final AuthRepository repo;

  LogOutUsecase(this.repo);

  @override
  Future<Either<Exception, bool>> call(NoParams params) async {
    return await repo.logOut();
  }
}
