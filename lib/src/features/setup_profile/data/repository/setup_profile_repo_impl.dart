import 'package:chat_app/src/core/extensions/object_extensions.dart';
import 'package:chat_app/src/features/setup_profile/domain/repository/setup_profile_repo.dart';
import 'package:chat_app/src/services/supa_database_service.dart';
import 'package:dartz/dartz.dart';

class SetupProfileRepoImpl implements SetupProfileRepo {
  final SupaDataBaseService dbService;

  SetupProfileRepoImpl({required this.dbService});

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
}
