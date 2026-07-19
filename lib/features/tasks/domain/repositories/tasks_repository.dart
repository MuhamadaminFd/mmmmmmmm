import 'package:dartz/dartz.dart';
import '../../../../core/base/pagination.dart';
import '../../../../core/error/failures.dart';
import '../entities/task_entity.dart';

abstract class TasksRepository {
  Future<Either<Failure, PaginatedResponse<TaskEntity>>> getTasks(int page, int pageSize);
  Future<Either<Failure, TaskEntity>> getTaskDetail(int id);
  Future<Either<Failure, TaskEntity>> updateTask(int id, bool completed);
}
