import 'package:dartz/dartz.dart';
import '../error/failures.dart';

abstract class BaseUseCase<Params, Result> {
  Future<Either<Failure, Result>> call(Params params);
}

class NoParams {}
