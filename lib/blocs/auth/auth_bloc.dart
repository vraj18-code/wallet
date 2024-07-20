import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
  }

  void _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final user = await _authRepository.user.first;
    if (user != null) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthUnauthenticated());
    }
  }

  void _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) async {
    emit(AuthAuthenticated());
  }

  void _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
    await _authRepository.signOut();
    emit(AuthUnauthenticated());
  }
}
