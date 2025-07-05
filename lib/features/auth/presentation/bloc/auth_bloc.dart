import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
  }) : super(const AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(const AuthLoading());
      try {
        final user = await loginUseCase(event.email, event.password);
        emit(AuthSuccess(user.uid));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<RegisterEvent>((event, emit) async {
      emit(const AuthLoading());
      try {
        final user = await registerUseCase(event.email, event.password);
        emit(AuthSuccess(user.uid));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<LogoutEvent>((event, emit) async {
      await logoutUseCase();
      emit(const AuthInitial());
    });
  }
}
