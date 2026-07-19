import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> login(String email, String password);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, bool>> checkAuth();
  Future<Either<Failure, String>> getToken();
}