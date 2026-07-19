import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/check_auth_usecase.dart';
import '../../domain/usecases/get_token_usecase.dart';
import '../../../../core/base/usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final CheckAuthUseCase _checkAuthUseCase;
  final GetTokenUseCase _getTokenUseCase;

  AuthBloc({
    required LoginUseCase loginUseCase,
    required LogoutUseCase logoutUseCase,
    required CheckAuthUseCase checkAuthUseCase,
    required GetTokenUseCase getTokenUseCase,
  })
      : _loginUseCase = loginUseCase,
        _logoutUseCase = logoutUseCase,
        _checkAuthUseCase = checkAuthUseCase,
        _getTokenUseCase = getTokenUseCase,
        super(AuthInitial()) {
    on<CheckAuthEvent>(_onCheckAuth);
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    on<GetTokenEvent>(_onGetToken);
  }

  Future<void> _onCheckAuth(CheckAuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _checkAuthUseCase(NoParams());
    result.fold(
      (failure) => emit(AuthUnauthenticated(failure.message)),
      (isAuthenticated) {
        if (isAuthenticated) {
          emit(AuthAuthenticated());
        } else {
          emit(AuthUnauthenticated(''));
        }
      },
    );
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _loginUseCase(LoginParams(event.email, event.password));
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthAuthenticated()),
    );
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _logoutUseCase(NoParams());
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthUnauthenticated('')),
    );
  }

  Future<void> _onGetToken(GetTokenEvent event, Emitter<AuthState> emit) async {
    final result = await _getTokenUseCase(NoParams());
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (token) => emit(AuthTokenReceived(token)),
    );
  }
}
