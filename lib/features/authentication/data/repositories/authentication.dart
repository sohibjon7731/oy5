import 'package:oy5/core/either/either.dart';
import 'package:oy5/core/exception/server_exception.dart';

import 'package:oy5/core/failure/failure.dart';
import 'package:oy5/features/authentication/data/data_source/remote.dart';
import 'package:oy5/features/authentication/data/models/authentication_user.dart';

import 'package:oy5/features/authentication/domain/entities/authentication_user.dart';

import '../../domain/repositories/authentication.dart';

class AuthenticationUserRepositoryImpl implements AuthenticationUserRepository {
  final AuthenticationRemoteDataSource _dataSource;

  const AuthenticationUserRepositoryImpl(
      {required AuthenticationRemoteDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<Either<Failure, AuthenticatedUserEntity>> getUser() async {
    try {
      final user = await _dataSource.getUser();
      return Right(AuthenticationUserModel.fromFirebaseUser(user));
    } on ServerException catch (error) {
      return Left(
          ServerFailure(message: error.errorMessage, code: error.errorCode));
    }
  }

  @override
  Future<Either<Failure, AuthenticatedUserEntity>> login(
      String email, String password) async {
    try {
      final user = await _dataSource.login(email, password);
      return Right(AuthenticationUserModel.fromFirebaseUser(user));
    } on ServerException catch (error) {
      return Left(
          ServerFailure(message: error.errorMessage, code: error.errorCode));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final response = await _dataSource.logout();
      return Right(response);
    } on ServerException catch (error) {
      return Left(
          ServerFailure(message: error.errorMessage, code: error.errorCode));
    }
  }

  @override
  Future<Either<Failure, AuthenticatedUserEntity>> signUp(
      String email, String password) async {
    try {
      final user = await _dataSource.signUp(email, password);
      return Right(AuthenticationUserModel.fromFirebaseUser(user));
    } on ServerException catch (error) {
      return Left(
          ServerFailure(message: error.errorMessage, code: error.errorCode));
    }
  }
}
