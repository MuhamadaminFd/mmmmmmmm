import 'package:dartz/dartz.dart';
import '../../../../core/base/pagination.dart';
import '../../../../core/base/usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/task_entity.dart';
import '../repositories/tasks_repository.dart';

class GetTasksUseCase extends BaseUseCase<GetTasksParams, PaginatedResponse<TaskEntity>> {
  final TasksRepository repository;

  GetTasksUseCase(this.repository);

  @override
  Future<Either<Failure, PaginatedResponse<TaskEntity>>> call(GetTasksParams params) async {
    return repository.getTasks(params.page, params.pageSize);
  }
}

class GetTasksParams {
  final int page;
  final int pageSize;

  GetTasksParams(this.page, this.pageSize);
}
