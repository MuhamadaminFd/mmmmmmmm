import 'package:dartz/dartz.dart';
import '../../../../core/base/usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/task_entity.dart';
import '../repositories/tasks_repository.dart';

class UpdateTaskUseCase extends BaseUseCase<UpdateTaskParams, TaskEntity> {
  final TasksRepository repository;

  UpdateTaskUseCase(this.repository);

  @override
  Future<Either<Failure, TaskEntity>> call(UpdateTaskParams params) async {
    return repository.updateTask(params.id, params.completed);
  }
}

class UpdateTaskParams {
  final int id;
  final bool completed;

  UpdateTaskParams(this.id, this.completed);
}
