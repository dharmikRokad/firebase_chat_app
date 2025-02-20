import 'package:dartz/dartz.dart';

abstract class SetupProfileRepo {
  Future<bool> sendOtp(String phone);
  Future<bool> verifyOtp(String phone, String otp);

  Future<Either<Exception, dynamic>> updateProfile(
    String uid,
    String email,
    Map<String, dynamic> data,
  );
}
