import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../models/auth_token_model.dart';
import 'dart:math';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource _localDataSource;

  // Test credentials
  static const String _testEmail = 'student@test.com';
  static const String _testPassword = '123456';

  AuthRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, bool>> login(String email, String password) async {
    try {
      // Validate credentials
      if (email != _testEmail || password != _testPassword) {
        return Left(AuthenticationFailure('Неверный email или пароль'));
      }

      // Generate fake token
      final token = _generateFakeToken();
      final model = AuthTokenModel(
        token: token,
        createdAt: DateTime.now(),
      );

      // Save token
      await _localDataSource.saveToken(model.token);
      return Right(true);
    } catch (e) {
      return Left(UnknownFailure('Ошибка при входе: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _localDataSource.removeToken();
      return Right(null);
    } catch (e) {
      return Left(UnknownFailure('Ошибка при выходе: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> checkAuth() async {
    try {
      final hasToken = await _localDataSource.hasToken();
      return Right(hasToken);
    } catch (e) {
      return Left(CacheFailure('Ошибка при проверке авторизации: $e'));
    }
  }

  @override
  Future<Either<Failure, String>> getToken() async {
    try {
      final token = await _localDataSource.getToken();
      if (token == null) {
        return Left(AuthenticationFailure('Токен не найден'));
      }
      return Right(token);
    } catch (e) {
      return Left(CacheFailure('Ошибка при получении токена: $e'));
    }
  }

  String _generateFakeToken() {
    final random = Random();
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    return 'fake_access_token_' + List.generate(20, (index) => chars[random.nextInt(chars.length)]).join();
  }
}
