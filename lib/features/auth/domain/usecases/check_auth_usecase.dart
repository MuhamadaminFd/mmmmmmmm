import 'package:dartz/dartz.dart';
import '../../../../core/base/usecase.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class CheckAuthUseCase extends BaseUseCase<NoParams, bool> {
  final AuthRepository repository;

  CheckAuthUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return repository.checkAuth();
  }
}