import 'package:oy5/core/failure/failure.dart';
import 'package:oy5/features/authentication/domain/entities/authentication_user.dart';

import '../../../../core/either/either.dart';

abstract class AuthenticationUserRepository {
  Future<Either<Failure, AuthenticatedUserEntity>> getUser();

  Future<Either<Failure, AuthenticatedUserEntity>> login(
      String email, String password);

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, AuthenticatedUserEntity>> signUp(
      String email, String password);
}
