import 'package:dartz/dartz.dart';
import '../../../../core/base/pagination.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/tasks_repository.dart';
import '../datasources/tasks_remote_datasource.dart';
import '../models/task_model.dart';

class TasksRepositoryImpl implements TasksRepository {
  final TasksRemoteDataSource _remoteDataSource;

  TasksRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, PaginatedResponse<TaskEntity>>> getTasks(int page, int pageSize) async {
    try {
      final allTasks = await _remoteDataSource.getTasks();
      
      // Client-side pagination
      final startIndex = (page - 1) * pageSize;
      final endIndex = startIndex + pageSize;
      
      final paginatedTasks = allTasks.sublist(
        startIndex,
        endIndex > allTasks.length ? allTasks.length : endIndex,
      );

      final hasNextPage = endIndex < allTasks.length;

      final entities = paginatedTasks.map((model) => _mapToEntity(model)).toList();

      return Right(PaginatedResponse(
        items: entities,
        currentPage: page,
        hasNextPage: hasNextPage,
        pageSize: pageSize,
        totalItems: allTasks.length,
      ));
    } catch (e) {
      return Left(NetworkFailure('Ошибка загрузки задач: $e'));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> getTaskDetail(int id) async {
    try {
      final taskModel = await _remoteDataSource.getTaskDetail(id);
      return Right(_mapToEntity(taskModel));
    } catch (e) {
      return Left(NetworkFailure('Ошибка загрузки задачи: $e'));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> updateTask(int id, bool completed) async {
    try {
      final taskModel = await _remoteDataSource.updateTask(id, completed);
      return Right(_mapToEntity(taskModel));
    } catch (e) {
      return Left(NetworkFailure('Ошибка обновления задачи: $e'));
    }
  }

  TaskEntity _mapToEntity(TaskModel model) {
    return TaskEntity(
      id: model.id,
      userId: model.userId,
      title: model.title,
      completed: model.completed,
    );
  }
}
