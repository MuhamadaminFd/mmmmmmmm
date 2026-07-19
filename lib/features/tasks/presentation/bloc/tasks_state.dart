part of 'tasks_bloc.dart';

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object?> get props => [];
}

class TasksInitial extends TasksState {
  const TasksInitial();
}

class TasksLoading extends TasksState {
  const TasksLoading();
}

class TasksSuccess extends TasksState {
  final List<TaskEntity> tasks;
  final int currentPage;
  final bool hasNextPage;
  final bool isLoadingMore;

  const TasksSuccess({
    required this.tasks,
    required this.currentPage,
    required this.hasNextPage,
    required this.isLoadingMore,
  });

  TasksSuccess copyWith({
    List<TaskEntity>? tasks,
    int? currentPage,
    bool? hasNextPage,
    bool? isLoadingMore,
  }) {
    return TasksSuccess(
      tasks: tasks ?? this.tasks,
      currentPage: currentPage ?? this.currentPage,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [tasks, currentPage, hasNextPage, isLoadingMore];
}

class TasksError extends TasksState {
  final String message;

  const TasksError(this.message);

  @override
  List<Object?> get props => [message];
}

class TaskDetailSuccess extends TasksState {
  final TaskEntity task;

  const TaskDetailSuccess(this.task);

  @override
  List<Object?> get props => [task];
}

class TaskDetailError extends TasksState {
  final String message;

  const TaskDetailError(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateTaskSuccess extends TasksState {
  final TaskEntity task;

  const UpdateTaskSuccess(this.task);

  @override
  List<Object?> get props => [task];
}

class UpdateTaskError extends TasksState {
  final String message;

  const UpdateTaskError(this.message);

  @override
  List<Object?> get props => [message];
}
