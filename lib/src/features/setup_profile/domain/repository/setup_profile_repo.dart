import 'package:dartz/dartz.dart';

abstract class SetupProfileRepo {
  Future<Either<Exception, dynamic>> updateProfile(
    String uid,
    String email,
    Map<String, dynamic> data,
  );
}
