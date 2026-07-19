import 'package:dartz/dartz.dart';
import '../../../../core/base/usecase.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class GetTokenUseCase extends BaseUseCase<NoParams, String> {
  final AuthRepository repository;

  GetTokenUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return repository.getToken();
  }
}