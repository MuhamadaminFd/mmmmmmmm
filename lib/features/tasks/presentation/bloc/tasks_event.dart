part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object?> get props => [];
}

class LoadTasksEvent extends TasksEvent {
  const LoadTasksEvent();
}

class LoadNextPageEvent extends TasksEvent {
  const LoadNextPageEvent();
}

class RefreshTasksEvent extends TasksEvent {
  const RefreshTasksEvent();
}

class GetTaskDetailEvent extends TasksEvent {
  final int taskId;

  const GetTaskDetailEvent(this.taskId);

  @override
  List<Object?> get props => [taskId];
}

class UpdateTaskEvent extends TasksEvent {
  final int taskId;
  final bool completed;

  const UpdateTaskEvent(this.taskId, this.completed);

  @override
  List<Object?> get props => [taskId, completed];
}
