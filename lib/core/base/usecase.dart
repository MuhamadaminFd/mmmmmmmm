import 'package:dartz/dartz.dart';
import '../error/failures.dart';

abstract class BaseUseCase<Params, Type> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {
  const NoParams();
}
