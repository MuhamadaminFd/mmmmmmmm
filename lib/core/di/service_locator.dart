import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/domain/usecases/check_auth_usecase.dart';
import '../../features/auth/domain/usecases/get_token_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/tasks/data/datasources/tasks_remote_datasource.dart';
import '../../features/tasks/data/repositories/tasks_repository_impl.dart';
import '../../features/tasks/domain/repositories/tasks_repository.dart';
import '../../features/tasks/domain/usecases/get_tasks_usecase.dart';
import '../../features/tasks/domain/usecases/get_task_detail_usecase.dart';
import '../../features/tasks/domain/usecases/update_task_usecase.dart';
import '../../features/tasks/presentation/bloc/tasks_bloc.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // External
  getIt.registerSingleton<http.Client>(http.Client());
  getIt.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());

  // Auth Data Sources
  getIt.registerSingleton<AuthLocalDataSource>(
    AuthLocalDataSourceImpl(getIt<FlutterSecureStorage>()),
  );

  // Auth Repositories
  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(getIt<AuthLocalDataSource>()),
  );

  // Auth UseCases
  getIt.registerSingleton<LoginUseCase>(
    LoginUseCase(getIt<AuthRepository>()),
  );
  getIt.registerSingleton<LogoutUseCase>(
    LogoutUseCase(getIt<AuthRepository>()),
  );
  getIt.registerSingleton<CheckAuthUseCase>(
    CheckAuthUseCase(getIt<AuthRepository>()),
  );
  getIt.registerSingleton<GetTokenUseCase>(
    GetTokenUseCase(getIt<AuthRepository>()),
  );

  // Auth BLoC
  getIt.registerSingleton<AuthBloc>(
    AuthBloc(
      loginUseCase: getIt<LoginUseCase>(),
      logoutUseCase: getIt<LogoutUseCase>(),
      checkAuthUseCase: getIt<CheckAuthUseCase>(),
      getTokenUseCase: getIt<GetTokenUseCase>(),
    ),
  );

  // Tasks Data Sources
  getIt.registerSingleton<TasksRemoteDataSource>(
    TasksRemoteDataSourceImpl(getIt<http.Client>()),
  );

  // Tasks Repositories
  getIt.registerSingleton<TasksRepository>(
    TasksRepositoryImpl(getIt<TasksRemoteDataSource>()),
  );

  // Tasks UseCases
  getIt.registerSingleton<GetTasksUseCase>(
    GetTasksUseCase(getIt<TasksRepository>()),
  );
  getIt.registerSingleton<GetTaskDetailUseCase>(
    GetTaskDetailUseCase(getIt<TasksRepository>()),
  );
  getIt.registerSingleton<UpdateTaskUseCase>(
    UpdateTaskUseCase(getIt<TasksRepository>()),
  );

  // Tasks BLoC
  getIt.registerSingleton<TasksBloc>(
    TasksBloc(
      getTasksUseCase: getIt<GetTasksUseCase>(),
      getTaskDetailUseCase: getIt<GetTaskDetailUseCase>(),
      updateTaskUseCase: getIt<UpdateTaskUseCase>(),
    ),
  );
}