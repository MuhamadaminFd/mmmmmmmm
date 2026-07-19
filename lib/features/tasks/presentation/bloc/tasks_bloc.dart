import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/usecases/get_tasks_usecase.dart';
import '../../domain/usecases/get_task_detail_usecase.dart';
import '../../domain/usecases/update_task_usecase.dart';
import '../../../../core/base/pagination.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final GetTasksUseCase _getTasksUseCase;
  final GetTaskDetailUseCase _getTaskDetailUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;

  static const int _pageSize = 20;
  int _currentPage = 1;
  List<TaskEntity> _allTasks = [];
  bool _isLoadingMore = false;
  bool _hasNextPage = true;

  TasksBloc({
    required GetTasksUseCase getTasksUseCase,
    required GetTaskDetailUseCase getTaskDetailUseCase,
    required UpdateTaskUseCase updateTaskUseCase,
  })
      : _getTasksUseCase = getTasksUseCase,
        _getTaskDetailUseCase = getTaskDetailUseCase,
        _updateTaskUseCase = updateTaskUseCase,
        super(TasksInitial()) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<LoadNextPageEvent>(_onLoadNextPage);
    on<RefreshTasksEvent>(_onRefreshTasks);
    on<GetTaskDetailEvent>(_onGetTaskDetail);
    on<UpdateTaskEvent>(_onUpdateTask);
  }

  Future<void> _onLoadTasks(LoadTasksEvent event, Emitter<TasksState> emit) async {
    if (_allTasks.isNotEmpty) return; // Already loaded

    emit(TasksLoading());
    _currentPage = 1;
    _allTasks = [];
    _isLoadingMore = false;
    _hasNextPage = true;

    final result = await _getTasksUseCase(GetTasksParams(_currentPage, _pageSize));

    result.fold(
      (failure) => emit(TasksError(failure.message)),
      (paginatedResponse) {
        _allTasks = paginatedResponse.items;
        _hasNextPage = paginatedResponse.hasNextPage;
        emit(TasksSuccess(
          tasks: paginatedResponse.items,
          currentPage: _currentPage,
          hasNextPage: _hasNextPage,
          isLoadingMore: false,
        ));
      },
    );
  }

  Future<void> _onLoadNextPage(LoadNextPageEvent event, Emitter<TasksState> emit) async {
    if (_isLoadingMore || !_hasNextPage) return; // Protection from multiple requests

    _isLoadingMore = true;
    final currentState = state;

    if (currentState is TasksSuccess) {
      emit(currentState.copyWith(isLoadingMore: true));

      _currentPage++;
      final result = await _getTasksUseCase(GetTasksParams(_currentPage, _pageSize));

      result.fold(
        (failure) {
          _isLoadingMore = false;
          _currentPage--; // Revert page number
          emit(currentState.copyWith(isLoadingMore: false));
        },
        (paginatedResponse) {
          _allTasks.addAll(paginatedResponse.items);
          _hasNextPage = paginatedResponse.hasNextPage;
          _isLoadingMore = false;
          emit(TasksSuccess(
            tasks: _allTasks,
            currentPage: _currentPage,
            hasNextPage: _hasNextPage,
            isLoadingMore: false,
          ));
        },
      );
    }
  }

  Future<void> _onRefreshTasks(RefreshTasksEvent event, Emitter<TasksState> emit) async {
    _currentPage = 1;
    _allTasks = [];
    _isLoadingMore = false;
    _hasNextPage = true;

    final result = await _getTasksUseCase(GetTasksParams(_currentPage, _pageSize));

    result.fold(
      (failure) => emit(TasksError(failure.message)),
      (paginatedResponse) {
        _allTasks = paginatedResponse.items;
        _hasNextPage = paginatedResponse.hasNextPage;
        emit(TasksSuccess(
          tasks: paginatedResponse.items,
          currentPage: _currentPage,
          hasNextPage: _hasNextPage,
          isLoadingMore: false,
        ));
      },
    );
  }

  Future<void> _onGetTaskDetail(GetTaskDetailEvent event, Emitter<TasksState> emit) async {
    final result = await _getTaskDetailUseCase(GetTaskDetailParams(event.taskId));

    result.fold(
      (failure) => emit(TaskDetailError(failure.message)),
      (task) => emit(TaskDetailSuccess(task)),
    );
  }

  Future<void> _onUpdateTask(UpdateTaskEvent event, Emitter<TasksState> emit) async {
    final result = await _updateTaskUseCase(UpdateTaskParams(event.taskId, event.completed));

    result.fold(
      (failure) => emit(UpdateTaskError(failure.message)),
      (updatedTask) {
        // Update the task in the list
        final index = _allTasks.indexWhere((task) => task.id == updatedTask.id);
        if (index != -1) {
          _allTasks[index] = updatedTask;
        }
        emit(UpdateTaskSuccess(updatedTask));
      },
    );
  }
}
