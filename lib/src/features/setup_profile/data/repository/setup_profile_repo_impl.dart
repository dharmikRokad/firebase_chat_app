import 'package:chat_app/src/core/extensions/object_extensions.dart';
import 'package:chat_app/src/features/setup_profile/domain/repository/setup_profile_repo.dart';
import 'package:chat_app/src/services/supa_auth_service.dart';
import 'package:chat_app/src/services/supa_database_service.dart';
import 'package:dartz/dartz.dart';

class SetupProfileRepoImpl implements SetupProfileRepo {
  final SupaDataBaseService dbService;
  final SupaAuthService authService;

  SetupProfileRepoImpl({
    required this.dbService,
    required this.authService,
  });

  @override
  Future<Either<Exception, dynamic>> updateProfile(
      String uid, String email, Map<String, dynamic> data) async {
    try {
      return Right(
        await dbService.updateProfile(
          uid: uid,
          email: email,
          data: data,
        ),
      );
    } on Exception catch (e) {
      log("upload profile pic err - $e");
      return Left(e);
    }
  }

  @override
  Future<bool> sendOtp(String phone) async {
    try {
      return await authService.sendOtp(phone);
    } on Exception catch (e) {
      log("send OTP - $e");
      return false;
    }
  }

  @override
  Future<bool> verifyOtp(String phone, String otp) async {
    try {
      final res = await authService.verifyOtp(phone, otp);
      return res.session != null;
    } on Exception catch (e) {
      log("send OTP - $e");
      return false;
    }
  }
}
