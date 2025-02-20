import 'package:chat_app/src/core/usecase.dart';
import 'package:chat_app/src/features/setup_profile/domain/repository/setup_profile_repo.dart';

class VerifyOtpUsecase extends Usecase<bool, (String, String)> {
  final SetupProfileRepo repo;

  VerifyOtpUsecase(this.repo);

  @override
  Future<bool> call((String, String) params) async {
    return await repo.verifyOtp(params.$1, params.$2);
  }
}
