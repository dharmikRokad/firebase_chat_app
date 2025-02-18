import 'package:chat_app/src/core/usecase.dart';
import 'package:chat_app/src/features/setup_profile/domain/repository/setup_profile_repo.dart';
import 'package:dartz/dartz.dart';

class UpdateProfileUsecase
    extends Usecase<Either<Exception, dynamic>, UpdateProfileParams> {
  final SetupProfileRepo repo;

  UpdateProfileUsecase(this.repo);

  @override
  Future<Either<Exception, dynamic>> call(UpdateProfileParams params) async {
    return await repo.updateProfile(
      params.uid,
      params.email,
      params.data,
    );
  }
}

class UpdateProfileParams {
  String uid;
  String email;
  Map<String, dynamic> data;

  UpdateProfileParams({
    required this.uid,
    required this.email,
    required this.data,
  });
}
