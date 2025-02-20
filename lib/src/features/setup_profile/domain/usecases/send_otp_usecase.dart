import 'package:chat_app/src/core/usecase.dart';
import 'package:chat_app/src/features/setup_profile/domain/repository/setup_profile_repo.dart';

class SendOtpUsecase extends Usecase<bool, String> {
  final SetupProfileRepo repo;

  SendOtpUsecase(this.repo);

  @override
  Future<bool> call(String params) async {
    return await repo.sendOtp(params);
  }
}
