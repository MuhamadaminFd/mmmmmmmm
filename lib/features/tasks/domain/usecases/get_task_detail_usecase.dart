import 'package:dartz/dartz.dart';
import '../../../../core/base/usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/task_entity.dart';
import '../repositories/tasks_repository.dart';

class GetTaskDetailUseCase extends BaseUseCase<GetTaskDetailParams, TaskEntity> {
  final TasksRepository repository;

  GetTaskDetailUseCase(this.repository);

  @override
  Future<Either<Failure, TaskEntity>> call(GetTaskDetailParams params) async {
    return repository.getTaskDetail(params.id);
  }
}

class GetTaskDetailParams {
  final int id;

  GetTaskDetailParams(this.id);
}
